class NotificationsController < ApplicationController
    include Webhookable


  skip_before_action :verify_authenticity_token

  def notify
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = client.messages.create from: ENV['TWILIO_PHONE'], to: ENV['CHAD_PHONE'], body: 'Learning to send SMS you are. This is great.', media_url: 'http://linode.rabasa.com/yoda.gif'
    
    render plain: message.status
  end


  def incoming

    phone_number = params[:From]

    user = User.find_by(phone: phone_number)
    @body = params[:Body].downcase

    @in_array = ['in', 'i', 'y', 'yes']
    @out_array = ['out', 'o', 'n', 'no']
        # split message into array of words
    @message_array = @body.split

    if user && Game.last.status == "open"
      game = Game.last 
      unless user.id == 1 && !@in_array.include?(@message_array[0]) && !@out_array.include?(@message_array[0])
        output = process_game_reply(user, game)
      end 
    # elsif user && Game.last.status == "closed"
    #   output = "Sorry, this game invite is expired. A new one should be created soon."
    end 

    #if I am the sender... 
    if user.phone == "+19179684122"

      quote_tags = Nugget.uniq.pluck(:tag).compact

      @message_body = process_message_text(@body)

      #let's add some commands (refactor later) 

      if @command == "quote"
        if @is_new
          quote = @message_body.capitalize 
          if @author 
            @author = @author.titleize
          end 

          Nugget.create(content: quote, tag: @tag, attributed_to: @author)
          message = "You just added: \n'#{quote}'"
          if @author 
            message += "\nAuthor is: #{@author.titleize}"
          end 
          if @tag
            message += "\nTag is: #{@tag}"
          end 
          send_me(message)
        end 
      elsif quote_tags.include? @command 
        quote = Nugget.where(tag: @command).all.sample
        message = "\'#{quote.content.capitalize}\'"
        if quote.attributed_to 
          message += "\n-- #{quote.attributed_to.titleize}"
        end 
        send_me(message)

      elsif @command == "shufflestatus"
        g = Game.last 
        player_names = []
        bench_names = []
        g.game_players.each do |gp|
          player_names << gp.user.first_name
        end

        g.game_benches.each do |gb|
          bench_names << gb.user.first_name
        end

        message = "Playing: #{player_names}\n Bench: #{bench_names}"
        send_me(message)
      elsif @command == "tags"
        message = quote_tags.join(", ")
        send_me(message)

          


      elsif @command == "shufflenew"

        if Date.today.wday == 2
          next_game = Game.create(game_date: Date.today, result: "TBD", status: "open", season_id: Season.last.id)
          send_team("Next game is tonight!!\n")

        else
          next_tuesday = Date.commercial(Date.today.year, 1+Date.today.cweek, 2)
          format_date = next_tuesday.strftime('%a, %b %d')
          next_game = Game.create(game_date: next_tuesday, result: "TBD", status: "open", season_id: Season.last.id)
          #send_me("Next game is on #{format_date}.\n")
          send_team("Next game is on #{format_date}.\n")
        end 
      elsif @command == "win"
        g = Game.last 
        g.result = "W"
        g.save 
        send_whole_team("Nice job on the win Ethel! That is our #{Game.where(result: "W").count.ordinalize} win for the season. So far we have #{Game.where(result: "L").count} losses.")

      elsif @command == "loss"
        g = Game.last 
        g.result = "L"
        g.save 
        send_whole_team("Tough break on the loss Ethel. That is our #{Game.where(result: "L").count.ordinalize} loss.\nBut we have #{Game.where(result: "L").count} wins.\nLook on the bright side!")
      else
        # output = "No command found. Hi #{user.first_name}. You still rock."
      end

    else
      output = "This is not the droid you are looking for."
    end

    #checking if output is nil just for me now 
    # if !output && user.id == 1
    #   output = "output is nil chad"
    # end 

    respond(output)

  end

  def process_message_text(body)      
      
      if body.match(/\@[a-zA-Z0-9]+/)
        group_sign = body.match(/\@[a-zA-Z0-9]+/)[0] 
        @group_name = group_sign[1..-1]
      end
      
      if body.match(/\[[\d]+\]/)
        num_invited_sign = body.match(/\[[\d]+\]/)[0] 
        @num_invited = num_invited_sign[1..-2].to_i
      end
      
      if body.match(/\#[a-zA-Z]+/)
        tag_sign = body.match(/\#[a-zA-Z]+/)[0] 
        @tag = tag_sign[1..-1]
      end

      if body.match(/\/[a-zA-Z]+/)
        command_sign = body.match(/\/[a-zA-Z]+/)[0] 
        @command = command_sign[1..-1]
      end

      if body.match(/\+[nN]/)
        new_flag = body.match(/\+[nN]/)[0] 
        @is_new = true
      end

      if body.match(/-[a-zA-Z]+ [a-zA-Z]+-|-[a-zA-Z]+-/)
        author_flag = body.match(/-[a-zA-Z]+ [a-zA-Z]+-|-[a-zA-Z]+-/)[0] 
        @author = author_flag[1..-2]
      end

      if body.match(/-[a-zA-Z]+/)
        first_name_flag = body.match(/-[a-zA-Z]+/)[0] 
      end


      if body.match(/[a-zA-Z]+-/)
        last_name_flag = body.match(/[a-zA-Z]+-/)[0] 
      end
      
      message_array = body.split

      sanitized_body = message_array.reject do |word| 
        word == group_sign || word == num_invited_sign || word == tag_sign || word == command_sign || word == new_flag || word == author_flag || word == first_name_flag || word == last_name_flag
      end
      sanitized_body.join(' ').downcase

      #output original body without any coded text

  end

  def process_game_reply(u, g)

        # define valid responses (positive and negative)
        # output = "Beginning of process game reply method."

        # create bench or playerobject based on response 
        # (maybe check if there is a response already?)
        if @in_array.include?(@message_array[0])
          GamePlayer.create(user_id: u.id, game_id: g.id)
        elsif @out_array.include?(@message_array[0])
          GameBench.create(user_id: u.id, game_id: g.id)
        end 

        total_replies = g.game_players.count + g.game_benches.count

        if total_replies <= 3
          output = "Thanks #{u.first_name} for your response. \nYou were #{total_replies.ordinalize} to get back to me. \nStill waiting for #{5 - total_replies} more replies. Please standby."
            send_me("For Chad: #{u.first_name} just replied with #{@message_array[0]}.")
            #add current_season_total_played || current_season_total_benched on the user model 
        elsif total_replies == 4

          output = "Thanks #{u.first_name} for your response. \nYou were #{total_replies.ordinalize} to get back to me. \nStill waiting for #{5 - total_replies} more reply. Please standby."
            send_me("For Chad: #{u.first_name} just replied with #{@message_array[0]}.")


        elsif total_replies == 5
            #ideal case scenario
            if g.game_players.count == 4 && g.game_benches.count == 1
              message = "Well, that worked out. \n Playing: #{g.game_players.all.first.user.first_name}, #{g.game_players.all.second.user.first_name}, #{g.game_players.all.third.user.first_name}, #{g.game_players.all.fourth.user.first_name}. \n Bench: #{g.game_benches.all.first.user.first_name}\n Don't forget the tangs! Go Ethel!"
              send_whole_team(message)
              g.status = "closed"
              g.save
              
              #need to association the bench 
              PlayerSeasonBenched.create(user_id: g.game_benches.all.first.user_id, season_id: Season.last.id)
              #need to association the players
              g.game_players.each do | gp |
                PlayerSeasonPlayed.create(user_id: gp.user_id, season_id: Season.last.id)
              end 

            elsif g.game_benches.count > 1 && g.game_benches.count <=5
              message = "Yikes. We have #{g.game_benches.count} players sitting out. Please initiate the substitue protocol. Human intervention required! Text Mike, Courtney, Loren.. anyone. Just get to four!"
              send_whole_team(message)

            elsif g.game_players.count == 5 
              player_hash = {}
              User.all.each do |user|
                player_hash[user.id] = user.season_benched 
              end 
              #this sorts the hash by value which is number of season benched
              player_hash.sort_by{|k, v| v}

              #this get the first aka lowest value from the hash 
              lowest_benched_total = player_hash.values[0]
              bench_array = []

              player_hash.each do |player, count|
                if count == lowest_benched_total
                  bench_array << player
                end 
              end 
              last_game_id = Game.last.id - 1 
              if last_game_id > 0
                if GameBench.find_by(game_id: last_game_id) 
                  last_sub_id = GameBench.find_by(game_id: last_game_id).user_id
                end 
              end 

              #exclude the last player who subbed from the array 
              if last_sub_id
              bench_array.delete(last_sub_id)
              end 

              sub = User.find(bench_array.sample)
              GamePlayer.find_by(user_id: sub.id, game_id: g.id).destroy
              GameBench.create(user_id: sub.id, game_id: g.id)

              message = "Randomly selected sub from #{player_hash.count} eligible players is #{sub.first_name}.\n In the game: #{g.game_players.all.first.user.first_name}, #{g.game_players.all.second.user.first_name}, #{g.game_players.all.third.user.first_name}, #{g.game_players.all.fourth.user.first_name}. \n Bench: #{g.game_benches.all.first.user.first_name} \n Have a great game and don't forget the tangs!"
              send_whole_team(message)

              g.status = "closed"
              g.save 

              #need to association the bench 
              PlayerSeasonBenched.create(user_id: g.game_benches.all.first.user_id, season_id: Season.last.id)
              #need to association the players
              g.game_players.each do | gp |
                PlayerSeasonPlayed.create(user_id: gp.user_id, season_id: Season.last.id)
              end 




            end 

        end 
        output 

  end 


  def send_team(message)

    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

        from = ENV['TWILIO_PHONE']
        User.all.each do |friend|
        @client.account.messages.create(
                    :from => from,
                    :to => friend.phone,
                    :body => "From Shufflebot:\nHey #{friend.first_name}, #{message} [In] or [Out]?"
                    )
        end
    
  end 


  def send_whole_team(message)

    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

        from = ENV['TWILIO_PHONE']
        User.all.each do |friend|
        @client.account.messages.create(
                    :from => from,
                    :to => friend.phone,
                    :body => "From Shufflebot: \n#{message}"
                    )
        end
    
  end 

  def send_me(message)

    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

        from = ENV['TWILIO_PHONE']
        @client.account.messages.create(
                    :from => from,
                    :to => "+19179684122",
                    :body => "#{message}"
                    )
    
  end 


  def respond(message)
    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end
    render text: response.text
  end

end
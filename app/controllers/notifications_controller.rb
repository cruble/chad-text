class NotificationsController < ApplicationController
    include Webhookable


  skip_before_action :verify_authenticity_token

  def notify
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    message = client.messages.create from: ENV['TWILIO_PHONE'], to: ENV['CHAD_PHONE'], body: 'Learning to send SMS you are. This is great.', media_url: 'http://linode.rabasa.com/yoda.gif'
    
    render plain: message.status
  end


  def incoming
    # collect phone number and message from SMS
    @phone_number = params[:From]
    @body = params[:Body].downcase
    # split SMS into array of words
    # message_array = @body.split

    #if I am the sender... 
    if @phone_number = "+19179684122"

      @user = "Chad"
      @message_body = process_chad_text(@body)

      #let's add some commands (refactor later) 

      if @command == "quote"
        output = "This is a random quote."
      elsif @command == "lane"
        output = "This is for lane. "
      elsif @command == "charles"
        output = "This is for Charles."
      elsif @command == "compliment"
        output = "You are very handsome."
      else
        output = "No command found. Hi #{@user}. You still rock."
      end

    else
      output = "This is not the droid you are looking for."
    end

    # see send_group method below
    # send_group(@message_body, @select_friends, @user.name)

    respond(output)

  end

  def process_chad_text(body)      
      
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
      
      message_array = body.split

      sanitized_body = message_array.reject do |word| 
        word == group_sign || word == num_invited_sign || word == tag_sign || word == command_sign
      end
      sanitized_body.join(' ').downcase

      #output origiinal body without any coded text

  end


  def respond(message)
    response = Twilio::TwiML::Response.new do |r|
      r.Message message
    end
    render text: response.text
  end

end
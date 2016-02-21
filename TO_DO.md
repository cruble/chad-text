
Next up: 


I like the idea of creating a command model.. that lists new commands and I can then list them all with instructions ... and categories. Command (description)


have to deal with multiple responses.. so if someone replies twice.. we know that tey are changing thier reply .. or that they are repeating their reply.. "already have you as having said you were in"  have they already  replied? 

Allow teammates to see quotes... 

Add /win and /loss with Season filter. 

support multiple tags 

page with abilite to read all text inputs and also another page to send a team text or send to a specific user (form)


have to do the associations with the players who played and the players who have benched.. all season. {{{feels like I did this in a stinky way.. couldn't I just make it a method on user.. then I don't need the associations. I just take total_season_benched user.total_season_benched(season).. and here I find the count of game benches for this season? games have a season ID... so I can just do that there... kind of ass backwards, Ruble... if I want total_bench_count and total_played_count on a user, then call the method.. I think you first GameBenches.where (user id is user and season_idl season.id). maybe I only need this seasons benched total. UGH! actually, it might just be fine. }}}

also.. need to add different groups... tennis, shuffleboard, etc... and add users with groups. Maybe more along the line of the textigo app. 

instead of all users.. let's add a group and to the group, we add users.. and that is how I get team (group_name)



heavy refactoring for tracking replies via session. 

parse the message 
get the user 
pull tags and commands 


if !user 
elsif session
  if session-player-reply
      if yes_array 
        keep the player object 
        output = "Got it. You are in. Standby for final lineup."
      elsif no_array
        delete player object 
        create bench object 
        output = "Got it. Sorry you can't make it now."
      else 
        "Sorry, I didn't get your response." 
      end 
  elsif session-bench-reply
      if yes_array 
        keep the bench object
        output = "Got it. We'll miss you!" 
      elsif no_array
        delete bench object 
        create player object
        output = "Got it. You're in. Standby for final lineup."
      else 
        "Sorry, I didn't get your response." 
      end 
  end 

elsif there_is_an_open_game and !subs
  process the game message

  total_replies > 1, <3 

  total_replies 4 

  total_replies 5

elsif user_is_a_sub
  if game open
    if yes_array 
      output = "Glad you can make it!"
      add player_object

      if total_players == 4 
        message = "We have four!"
        send_whole_team("Message")
        game.status = "closed"
      elsif total_players < 4
        message = "sub.name is in, but we still only have x total players"
        send_whole_team("Message")
      end  
    else if no_array 
      output = "Sorry #name you can't make it! Next time."
  elsif game_closed 
    output = "Sorry, we already got out fourth for the game. They replied xxx seconds/minutes/hours before you. Next time!"

  

elsif there_is_no_open_game
  output = "Sorry the game is currently closed. You'll need a human to deal with any further changes now."

elsif there is a command 

end 


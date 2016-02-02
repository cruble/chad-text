
Next up: 
Figure out secrets.yml... its currently tracked by GIT.. and seems like this tutorial needs to use that file. 

Maybe I use ENV variables. 

I'm not sure how Heroku is getting my ENV variables... They aren't on Github.. and are not tracked. I should have to add them.. unless there is a remnant from last version of the app (but it doesn't show up). It should be crashing. 

I like the idea of creating a command model.. that lists new commands and I can then list them all with instructions ... and categories. Command (description)


have to deal with multiple responses.. so if someone replies twice.. we know that tey are changing thier reply .. or that they are repeating their reply.. "already have you as having said you were in"  have they already  replied? 


add a current status code for shufflestatus 

Allow teammates to see quotes... 

Add /win and /loss with Season filter. 

support multiple tags 

page with abilite to read all text inputs and also another page to send a team text or send to a specific user (form)

**** have to be able to destroy a game and destroy the game benches and game players. i think that's the destroy-depend flag or domething like that. have wrong number of games.. becuase of my fuzzy fingers. 

have to do the associations with the players who played and the players who have benched.. all season. {{{feels like I did this in a stinky way.. couldn't I just make it a method on user.. then I don't need the associations. I just take total_season_benched user.total_season_benched(season).. and here I find the count of game benches for this season? games have a season ID... so I can just do that there... kind of ass backwards, Ruble... if I want total_bench_count and total_played_count on a user, then call the method.. I think you first GameBenches.where (user id is user and season_idl season.id). maybe I only need this seasons benched total. UGH! actually, it might just be fine. }}}








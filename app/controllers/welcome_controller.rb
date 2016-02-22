class WelcomeController < ApplicationController
  def index 
    @users = User.all 
    @games = Game.all 
    @user = current_user
    @nuggets = Nugget.all 
    
  end 

end

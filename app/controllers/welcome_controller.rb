class WelcomeController < ApplicationController 
    def index 
        @users = User.all
        
        if session[:user_id] != nil
            @user = User.find(session[:user_id])
        end
    end 
end 
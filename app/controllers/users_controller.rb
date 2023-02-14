class UsersController <ApplicationController 
    def new 
        @user = User.new()
    end 

    def show 
        @user = User.find(params[:id])
    end 

    def create
        if user_params[:password] == user_params[:password_confirmation]
            user = User.create(user_params)
            if user.save
                redirect_to user_path(user)
            else  
                flash[:error] = user.errors.full_messages.to_sentence
                redirect_to register_path
            end 
        else
            flash[:error] = "Passwords don't match. Are you sure you typed that correctly?"
            redirect_to register_path
        end
    end 

    def login_form
        
    end

    def login_user
        user = User.find_by(email: login_params[:email])

        if user.authenticate(login_params[:password])
            flash[:success] = "Welcome, #{user.name}!"
            redirect_to user_path(user.id)
        else
            flash[:error] = "Sorry, your credentials are bad."
            render :login_form
        end
    end
    
    private 

    def login_params
        params.permit(:email, :password)
    end

    def user_params 
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 
class UsersController < ApplicationController
    def new
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            flash[:notice] = "valid!"
            redirect_to sessions_new_path
        else
            flash[:error] = "Error: please try again"
            redirect_to new_user_path
        end
    end

    private
    def user_params
        params.require(:user).permit(:email, :name, :password)
    end
end

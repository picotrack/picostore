class SessionsController < ApplicationController
  def new
  end

  def create
    session_params = params.permit(:email, :name, :password)
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id]= @user.id
      flash[:notice] = "Login is Done!"
      redirect_to sessions_new_path
    else
      flash[:notice] = "Login is not valid"
      redirect_to sessions_new_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed Out!"
    redirect_to sessions_new_path
  end
end

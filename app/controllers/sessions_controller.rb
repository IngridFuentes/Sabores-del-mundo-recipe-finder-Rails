class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      user = User.find_or_create_by_omniauth(auth_hash)

      # if auth
      #   user_info = request.env["omniauth.auth"]

      #   user = User.find_or_create_by(uid: auth["uid"]) do |user|
      #     # user.id = user_info["uid"]
      #     user.username = user_info["info"]["name"]
      #     user.email = auth["info"]["email"]
      #     user.password = SecureRandom.hex
      #   end

      session[:user] = user.id
      redirect_to root_path
    else
      user = User.find_by(:email => params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        # i am saving the user id on the session
        flash[:success] = "You have successfully logged in"

        redirect_to user_path(user)
      else
        flash.now[:danger] = "There was something wrong with your login information"
        render "sessions/new"
      end
    end
  end

  def destroy
    session.delete(:user_id)
    # session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

  private

  def auth
    request.env["omniauth.auth"]
  end
end

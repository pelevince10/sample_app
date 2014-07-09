class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if params[:remember_me]
        sign_in user
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_url, :notice => "Logged in!"
     else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
      sign_out
      cookies.delete(:auth_token)
      redirect_to root_url, :notice => "Logged out!"
  end
end
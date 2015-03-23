class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :login]

  def new
  end

  def login
    user = User.find_by(email: login_params[:email])
    if (user && (user.encrypted_password == Digest::SHA1.hexdigest(login_params[:password])))

      user.set_session_token
      user.save

      session[:user_token] = user.session_token

      flash[:notice] = "Logged In, " + user.first_name + " " + user.last_name +  "!"
      redirect_to root_path
    else
      flash[:notice] = "Email or password invalid"
      redirect_to login_path
    end
  end

  private
  def login_params
    params.permit(:email, :password, :token)
  end

end

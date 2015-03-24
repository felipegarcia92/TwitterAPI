class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :authenticate_user

  def authenticate_user
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    if params[:token].present?
      @current_user ||= User.find_by(session_token: params[:token])
    else
      session_token = session[:user_token]
      @current_user ||= User.find_by(session_token: session_token)
    end
  end

  def render_unauthorized
    render json: "401 Authenticate Exception", status: 401
  end
end

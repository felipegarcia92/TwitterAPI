require 'carrierwave/orm/activerecord'

class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User successfully created"
      redirect_to root_path
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to new_user_path, alert: "Error creating user."
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :avatar)
  end

end

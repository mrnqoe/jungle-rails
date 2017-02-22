class Admin::UsersController < ApplicationController

  before_filter :authenticate

  def show
    @users = User.find params[:id]
  end

  def new
    @user = User.new
  end

# WOULDNT IT BE COOL IF GOD COULD CREATE USERS ???
  # def create
  #   @user = User.new(user_params)
  #
  #   if @user.save
  #     session[:user_id] = user.id
  #     redirect_to '/'
  #   else
  #     redirect_to '/signup'
  #   end
  # end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USER'] && password == ENV['ADMIN_PASS']
    end
  end

  def user_params
    params.require(:user).permit(
    :email,
    :password,
    :password_confirmation,
    :first_name,
    :last_name)
  end

end

class Admin::UsersController < ApplicationController

  def show
    @users = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to [:admin, :users], notice: 'User created!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
    :email,
    :password,
    :password_confirmation,
    :first_name,
    :last_name)
  end

end

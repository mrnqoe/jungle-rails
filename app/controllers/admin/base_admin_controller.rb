class Admin::BaseAdminController < ApplicationController
  protected

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

  def category_params
    params.require(:category).permit(:name)
  end

end

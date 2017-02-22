class Admin::DashboardController < ApplicationController

  before_filter :authenticate

  def show
    @users = User.all
  end

  private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USER'] && password == ENV['ADMIN_PASS']
    end
  end
end

class Admin::UsersController < Admin::BaseAdminController

  before_filter :authenticate

  private

    def show
      @users = User.find params[:id]
    end

    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

end

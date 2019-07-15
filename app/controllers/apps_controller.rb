class AppsController < ApplicationController

  def index
    @is_client_verified = is_client_verified
    if !@is_client_verified
      redirect_to root_path
    else
      @user = user
      @apps = App.where(user_id: @user.id)
    end
  end

  def new
  end

end

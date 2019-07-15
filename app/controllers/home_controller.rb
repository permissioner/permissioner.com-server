class HomeController < ApplicationController
  def index
    @user = user
    @is_client_verified = is_client_verified
  end

  def how_it_works
    @user = user
    @is_client_verified = is_client_verified
  end

  def documentation
    @user = user
    @is_client_verified = is_client_verified
  end
  
end

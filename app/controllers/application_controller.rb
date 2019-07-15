require 'securerandom'
require "#{Rails.root}/app/utils/database"
require "#{Rails.root}/app/utils/json_web_token"

class ApplicationController < ActionController::Base

  protect_from_forgery

  def reload
    redirect_back(fallback_location: root_path)
  end

  def signin
    user = Database.new.fetchUser(params[:username])
    permissioner = App.find_by_name('Permissioner')
    if user.nil?
      #TODO: let user know that user couldn't be found in database by username
      render plain: "The username doesn't exist in our database"
    elsif user.can_sign_into_app(permissioner)
      set_jwt_cookie(user)
      UserMailer.with(
        user: user,
        client: client,
        app: permissioner
      ).verification_link_email.deliver_now
      redirect_back(fallback_location: root_path)
    else
      #TODO: let user know that he is not allowed to sign into permissioner
      render plain: "You are not allowed to sign into Permissioner. Contact n.autzen@gmail.com to request access."
    end
  end

  def signout
    cookies.delete :jwt
    redirect_back(fallback_location: root_path)
  end


  def user
    jwt = cookies[:jwt]
    if jwt
      decoded_token = JsonWebToken.new.decode(jwt)
      User.find_by_id(decoded_token["user"])
    end
  end

  def client
    jwt = cookies[:jwt]
    if jwt
      decoded_token = JsonWebToken.new.decode(jwt)
      Client.find_by_id(decoded_token["client"])
    end
  end

  def set_jwt_cookie(user)
    jwt = new_jwt(user)
    cookies[:jwt] = {
      :value => jwt,
      :expires => 10.year.from_now,
      :httponly => true
    }
  end

  def new_jwt(user)
    client = new_client
    payload = { iss: 'https://permissioner.com', client: client.id, user: user.id }
    JsonWebToken.new.encode(payload)
  end

  def new_client
    App.find_by_name('Permissioner').clients.create(
      language_code: 'en_US',
      verification_token: SecureRandom.hex,
      verified: false
    )
  end

  def is_client_verified
    client.nil? ? false : client.verified
  end

end

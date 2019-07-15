require "#{Rails.root}/app/utils/database"

class ApisController < ApplicationController

  def sign_in_cancellation
    #different api versions possible: params[:api_version]
    client.destroy
  end

  def verification
    #different api versions possible: params[:api_version]
    client = Client.find_by_id(Integer(params[:client]))
    if !client.nil?
      if !client.expired && client.token_matches(params[:token])
        client.verify
        @app = App.find_by_name("Permissioner")
      else
        #validation failed: either link was too old or token doesn't match
        client.destroy
      end
    else
      render plain: "Client not found in database."
    end
  end

  def authenticate_user
    #different api versions possible: params[:api_version]
    error_message = nil
    permissioner_client_token = nil
    app = App.find_by_app_key(params[:app_key])
    if app.nil?
      error_message = "app_not_found"
    elsif app.is_rejected
      error_message = "app_status_rejected"
    else
      user = Database.new.fetchUser(params[:user])
      if user
        if user.can_sign_into_app(app)
          new_client = app.new_client_with_language_code(params[:language])
          payload = { iss: 'https://permissioner.com', client: new_client.id, user: user.id }
          permissioner_client_token = JsonWebToken.new.encode(payload)
          UserMailer.with(
            user: user,
            client: new_client,
            app: app
          ).verification_link_email.deliver_now
        else
          error_message = "user_access_denied"
        end
      else
        error_message = "invalid_user"
      end
    end

    json_response = {
      error: error_message,
      permissioner_client_token: permissioner_client_token
    }
    render json: json_response
  end

end

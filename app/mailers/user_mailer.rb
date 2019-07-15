class UserMailer < ApplicationMailer

  default from: 'Permissioner <no_reply@permissioner.com>'

  def verification_link_email
    @app = params[:app]
    @client = params[:client]
    @base_url = ActionMailer::Base.default_url_options[:host]
    mail(to: params[:user].email_normalized, subject: 'Verify your Sign In with a magic button')
  end

end

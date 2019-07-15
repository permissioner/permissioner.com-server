class User < ApplicationRecord
  has_many :apps
  validates :email_normalized, uniqueness: true
  validates :email_normalized, format: { with: URI::MailTo::EMAIL_REGEXP }

  def can_sign_into_app(app)
    app.user_access_list.split(' ').each do |user|
      if email_normalized == user || username_normalized == user
        return true
      elsif user.start_with? '*'
        return email_normalized.split("@")[1] == user.split("@")[1]
      end
    end
    false
  end
end

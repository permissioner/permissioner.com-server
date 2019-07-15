class Client < ApplicationRecord
  belongs_to :app

  def expired
    created_at < 1.hour.ago
  end

  def token_matches(token)
    verification_token == token
  end

  def verify
    update_attributes(verification_token: nil, verified: true)
  end
end

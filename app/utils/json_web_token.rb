require 'jwt'

class JsonWebToken

  @@hmac_secret = ENV['JWT_SECRET']

  def encode(payload)
    token = JWT.encode payload, @@hmac_secret, 'HS256'
  end

  def decode(jwt)
    if jwt && jwt.split('.').length == 3
      decoded_token = JWT.decode jwt, @@hmac_secret, true, { algorithm: 'HS256' }
      decoded_token[0]
    end
  end

end

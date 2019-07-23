require 'jwt'

class JsonWebToken

  def encode(payload)
    token = JWT.encode payload, ENV['JWT_SECRET'], 'HS256'
  end

  def decode(jwt)
    if jwt && jwt.split('.').length == 3
      decoded_token = JWT.decode jwt, ENV['JWT_SECRET'], true, { algorithm: 'HS256' }
      decoded_token[0]
    end
  end

end

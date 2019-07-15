require 'jwt'

class JsonWebToken

  @@hmac_secret = "77c631e25c43e07466c9a65bcafe136624d0948ba51f31dec2e136b2ff3030277565e4fff09819075b79a33337d924423c05e4e8195b6ec148e14dc35fffcb79e695ca7e7ad839234f1ab04d80ad2ca1424c58af73ab5721f99ce6a6287c7e70f9ce63ab"

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

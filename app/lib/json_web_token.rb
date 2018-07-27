class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
  	# Set expiration to 24 hours from creation
  	payload[:exp] = exp.to_i

  	# Sign token with application secret
  	JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
  	# Get payload, which is the first index of the decoded array
  	body = JWT.decode(token, HMAC_SECRET)[0]

  	HashWithIndifferentAccess.new body

  	# Rescue from decode errors
    rescue JWT::DecodeError => e
      # Raise a custom error to be handled by custom handler
      raise ExceptionHandler::InvalidToken, e.message
  end
  
end

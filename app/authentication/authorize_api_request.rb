class AuthorizeApiRequest
  def initialize(headers = {})
  	@headers = headers
  end

  def call
  	{ user: user }
  end

  private

  attr_reader :headers

  def user
  	# Check to see if user is in database
  	# Memoize the user object

  	@user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token

  	# Handle if user is not found
	rescue ActiveRecord::RecordNotFound => e
		# Raise Custom Error
		raise(
		  ExceptionHandler::InvalidToken,
      	  ("#{Message.invalid_token} #{e.message}")
		)
  end

  def decoded_auth_token
  	@decoded_auth_token ||= JsonWebToken.decode(http_auth_header) 
  end

  def http_auth_header
  	if headers['Authorization'].present?
  		return headers['Authorization'].split(' ').last
  	end
  	  raise(ExceptionHandler::MissingToken, Message.missing_token) 
  end

end

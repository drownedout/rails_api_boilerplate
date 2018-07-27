module ExceptionHandler
  # Custom Standard Error sub-classes to help handle exceptions raised
  
  # By defining error classes as sub-classes of standard error, 
  # we're able to rescue_from them once raised

  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches 'Standard Error'
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
  	# Define custom handlers
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    
  	rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
  	rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
  	rescue_from ExceptionHandler::RecordInvalid, with: :four_twenty_two
  	rescue_from ExceptionHandler::RecordInvalid, with: :four_twenty_two

  	rescue_from ActiveRecord::RecordNotFound do |e|
  		json_response({ message: e.message }, :not_found)
  	end
  end

  private

  # JSON response of 422; unprocessable entity
  def four_twenty_two(e)
  	json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response of 401; unauthorized 
  def unauthorized_request(e)
  	json_response({ message: e.message }, :unauthorized)
  end
end
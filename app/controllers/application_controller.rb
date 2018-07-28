class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Response
  include ExceptionHandler

  # Uncomment below to force authorization before requests

  #before_action :authorize_request
  #attr_reader :current_user

  private

  def authorize_request
  	@current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

end

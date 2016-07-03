class ApplicationController < ActionController::API
  include ExceptionHandler
  include Response
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    json_response({ error: Message.unauthorized }, 401) unless @current_user
  end
end

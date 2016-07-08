class ApplicationController < ActionController::API
  include ExceptionHandler
  include Response
  include BucketlistUtilities

  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    result = AuthorizeApiRequest.new(request.headers).call
    @token = result[:token]
    @current_user = result[:user]
    if current_user_invalid_tokens.include? @token
      raise ExceptionHandler::ExpiredSignature, Message.expired_token
    end
    @current_user
  end

  def current_user_invalid_tokens
    tokens = []
    @current_user.invalid_tokens.each { |t| tokens << t.token }
    tokens
  end
end

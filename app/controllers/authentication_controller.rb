class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: :authenticate

  def authenticate
    @auth_token = AuthenticateUser.new(params[:email], params[:password]).call
    json_response(auth_token: @auth_token)
  end

  def logout
    @current_user.invalid_tokens.create!(token: @token)
    json_response(message: "Successfully logged out")
  end
end

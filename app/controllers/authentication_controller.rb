class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    comamnd = AuthenticateUser.call(params[:email], params[:password])

    if comamnd.success?
      json_response({ auth_token: comamnd.result })
    else
      json_response({ error: command.errors }, :unauthorized)
    end
  end
end

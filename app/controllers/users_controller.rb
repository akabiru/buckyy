class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def create
    user = User.new(user_params)
    if user.save
      auth_token = AuthenticateUser.new(user.email, user.password).call
      response = { message: Message.account_created, auth_token: auth_token }
      json_response(response, :created)
    else
      json_response(
        { message: Message.account_not_created },
        :unprocessable_entity
      )
    end
  end

  private

  def user_params
    params.permit(
      :firstname,
      :lastname,
      :email,
      :password,
      :password_confirmation
    )
  end
end

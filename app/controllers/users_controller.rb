class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.new(user_params)
    if user.save
      json_response(Message.account_created, :created)
    else
      json_response(Message.account_not_created, :unprocessable_entity)
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

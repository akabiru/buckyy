module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class InvalidToken < StandardError; end
  class MissingToken < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotSaved, with: :four_twenty_two
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response(e.message, :not_found)
    end

    rescue_from ExceptionHandler::AuthenticationError do |e|
      json_response(e.message, :unauthorized)
    end

    rescue_from JWT::ExpiredSignature do
      json_response(Message.expired_token, :unprocessable_entity)
    end
  end

  private

  def four_twenty_two(e)
    json_response(e.message, :unprocessable_entity)
  end
end

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response(e.message, :not_found)
    end

    rescue_from ActiveRecord::RecordNotSaved do |e|
      json_response(e.message, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response(e.message, :unprocessable_entity)
    end

    rescue_from BucketlistError::AuthenticationError do |e|
      json_response(e.message, :unauthorized)
    end

    rescue_from BucketlistError::InvalidToken do |e|
      json_response(e.message, :unprocessable_entity)
    end

    rescue_from BucketlistError:: MissingToken do |e|
      json_response(e.message, :unprocessable_entity)
    end

    rescue_from JWT::ExpiredSignature do
      json_response(Message.expired_token, :unprocessable_entity)
    end
  end
end

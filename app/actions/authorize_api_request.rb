class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || raise(InvalidToken, Message.invalid_token)
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers["Authorization"].present?
      return headers["Authorization"].split(" ").last
    else
      raise(BucketlistError::MissingToken, Message.missing_token)
    end
  end
end

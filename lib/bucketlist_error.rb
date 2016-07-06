class BucketlistError < StandardError
  attr_reader :message

  def initialize(message)
    @message = message
  end
end

class AuthenticationError < BucketlistError ; end
class InvalidToken < BucketlistError ; end
class MissingToken < BucketlistError ; end

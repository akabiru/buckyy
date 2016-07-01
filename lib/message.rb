class Message
  class << self
    def not_found(record = "record")
      "Sorry, #{record} not found."
    end

    def invalid_credentials
      "Invalid credetials"
    end

    def invalid_token
      "Invalid token"
    end

    def missing_token
      "Missing token"
    end

    def unauthorized
      "Unauthorized request"
    end
  end
end

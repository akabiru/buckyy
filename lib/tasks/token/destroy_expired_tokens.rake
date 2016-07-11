namespace :token do
  desc "Delete Expired tokens from the database"
  task destroy_expired_tokens: :environment do
    puts "Deleting expired tokens from the database."
    log = ActiveSupport::Logger.new("log/destroy_expired_tokens.log")
    log.info "Task started at #{Time.now}"
    Token.all.pluck(:token) do |token|
      begin
        JsonWebToken.decode(token)
      rescue JWT::ExpiredSignature
        Token.find_by(token: token).destroy
        log.info "Token: #{token} deleted."
      end
    end
    log.info "Task finished at #{Time.now}"
    log.close
  end
end

require "rails_helper"

RSpec.shared_examples_for "an exception handler" do
  it { should rescue_from(ActiveRecord::RecordNotFound) }

  it { should rescue_from(ActiveRecord::RecordNotSaved) }

  it { should rescue_from(ActiveRecord::RecordInvalid) }

  it { should rescue_from(ExceptionHandler::InvalidToken) }

  it { should rescue_from(ExceptionHandler::MissingToken) }

  it { should rescue_from(ExceptionHandler::AuthenticationError) }

  it { should rescue_from(ExceptionHandler::ExpiredSignature) }
end

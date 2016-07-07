require "rails_helper"

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:auth_obj) { described_class.new(user.email, user.password) }
  subject(:invalid_auth_obj) { described_class.new("foo", "bar") }

  describe "#call" do
    context "when user exists" do
      it "returns an auth token" do
        token = auth_obj.call
        expect(token).not_to be_nil
      end
    end

    context "when user does not exist" do
      it "raises an authentication error" do
        expect { invalid_auth_obj.call }.
          to raise_error(
            ExceptionHandler::AuthenticationError,
            "Invalid credetials"
          )
      end
    end
  end
end

require "rails_helper"

RSpec.describe API::V1::ApplicationController, type: :controller do
  let!(:user) { create(:user) }
  let!(:headers) { set_headers }
  let!(:bucketlist) { create(:bucketlist, created_by: user.id) }

  it { should rescue_from(ActiveRecord::RecordNotFound) }

  it { should rescue_from(ActiveRecord::RecordNotSaved) }

  it { should rescue_from(ActiveRecord::RecordInvalid) }

  it { should rescue_from(ExceptionHandler::InvalidToken) }

  it { should rescue_from(ExceptionHandler::MissingToken) }

  it { should rescue_from(ExceptionHandler::AuthenticationError) }

  it { should rescue_from(JWT::ExpiredSignature) }

  describe "#authenticate_request" do
    before { allow(request).to receive(:headers).and_return(headers) }

    it "sets the current user" do
      expect(subject.instance_eval { authenticate_request }).to eq(user)
    end
  end
end

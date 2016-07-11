require "rails_helper"
require Rails.root.join "spec/concerns/exception_handler.rb"

RSpec.describe API::V1::ApplicationController, type: :controller do
  let!(:user) { create(:user) }
  let!(:headers) { set_headers }
  let!(:invalid_headers) { set_invalid_headers }
  let!(:bucketlist) { create(:bucketlist, created_by: user.id) }

  it_behaves_like "an exception handler"

  describe "#authenticate_request" do
    context "when auth token is passed" do
      before { allow(request).to receive(:headers).and_return(headers) }

      it "sets the current user" do
        expect(subject.instance_eval { authenticate_request }).to eq(user)
      end
    end

    context "when auth token is not passed" do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it "raises MissingToken error" do
        expect { subject.instance_eval { authenticate_request } }.
          to raise_error(ExceptionHandler::MissingToken, /Missing token/)
      end
    end
  end
end

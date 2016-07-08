require "rails_helper"
require Rails.root.join "spec/concerns/exception_handler_spec.rb"

RSpec.describe API::V1::ApplicationController, type: :controller do
  let!(:user) { create(:user) }
  let!(:headers) { set_headers }
  let!(:bucketlist) { create(:bucketlist, created_by: user.id) }

  it_behaves_like "an exception handler"

  describe "#authenticate_request" do
    before { allow(request).to receive(:headers).and_return(headers) }

    it "sets the current user" do
      expect(subject.instance_eval { authenticate_request }).to eq(user)
    end
  end
end

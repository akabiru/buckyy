require "rails_helper"

RSpec.describe AuthenticationController, type: :controller do
  let!(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:user).slice(:email, :password) }
  let(:invalid_attributes) do
    { email: Faker::Internet.email, password: Faker::Lorem.word }
  end

  describe "#authenticate" do
    context "when valid request" do
      before { post :authenticate, valid_attributes }

      it "returns an authentication token" do
        expect(json["auth_token"]).not_to be_nil
      end
    end

    context "when invalid request" do
      before { post :authenticate, invalid_attributes }

      it "returns a failure message" do
        expect(response.body).to match(/Invalid credentials/)
      end
    end
  end
end

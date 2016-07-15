require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end
  describe "#create" do
    context "when valid request" do
      let!(:req) { post :create, valid_attributes }

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "returns an authentication token" do
        expect(json["auth_token"]).not_to be_nil
      end

      it_behaves_like "a http response", 201, /Account created successfully/
    end

    context "when invalid request" do
      let!(:req) { post :create, {} }

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it_behaves_like "a http response", 422, /Account could not be created/
    end
  end
end

require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { build(:user) }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end
  describe "#create" do
    context "when valid request" do
      before { post :create, valid_attributes }

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "returns an authentication token" do
        expect(json["auth_token"]).not_to be_nil
      end

      it "returns a success message" do
        expect(json["message"]).to match(/Account created successfully/)
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when invalid request" do
      before { post :create, {} }

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "returns an error message" do
        expect(response.body).to match(/Account could not be created/)
      end

      it "returns status 422" do
        expect(response).to have_http_status(422)
      end
    end
  end
end

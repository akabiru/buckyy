require "rails_helper"

RSpec.describe API::V1::BucketlistsController, type: :controller do
  let!(:bucketlist) { create(:bucketlist) }

  describe 'GET #index' do
    before { get :index }

    it "returns a status code 200" do
      expect(response.status).to eq(200)
    end

    it "assigns bucketlists to @bucketlists" do
      expect(assigns(:bucketlists)).to eq(Bucketlist.all)
    end
  end

  describe 'GET #show' do
    before { get :show, id: bucketlist.id }

    it "returns a status code 200" do
      expect(response.status).to eq(200)
    end

    it "assigns bucketlist to @bucketlist" do
      expect(assigns(:bucketlist)).to eq(bucketlist)
    end

    it "shows a bucketlist" do
      parsed_response = json(response.body)
      expect(parsed_response["name"]).to eq(bucketlist.name)
    end
  end

  describe 'POST #create' do
    let(:bucketlist) { build(:bucketlist) }

    context "when valid request" do
      it "returns a status code 201" do
        post :create, name: bucketlist.name, created_by: bucketlist.created_by
        expect(response.status).to eq(201)
      end

      it "creates a new bucketlist" do
        expect do
          post :create, name: bucketlist.name, created_by: bucketlist.created_by
        end.to change(Bucketlist, :count).by(1)
      end
    end

    context "when invalid request" do
      it "returns a status code 422" do
        post :create, name: nil, created_by: bucketlist.created_by
        expect(response.status).to eq(422)
      end

      it "does not create a new bucketlist" do
        expect do
          post :create, name: nil, created_by: bucketlist.created_by
        end.to change(Bucketlist, :count).by(0)
      end
    end
  end
end

require "rails_helper"

RSpec.describe API::V1::BucketlistsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:headers) { set_headers }
  let!(:bucketlist) { create(:bucketlist, created_by: user.id) }

  before { allow(request).to receive(:headers).and_return(headers) }

  it_behaves_like "an api controller", id: "not-existing"

  describe 'GET #index' do
    let!(:req) { get :index }

    it "returns a status code 200" do
      expect(response).to have_http_status(200)
    end

    it "assigns bucketlists to @bucketlists" do
      expect(assigns(:bucketlists)).to eq(Bucketlist.all)
    end

    context "when query is present" do
      context "when the record exists" do
        it "finds the bucketlist" do
          get :index, q: bucketlist.name
          expect(json.first["name"]).to eq(bucketlist.name)
        end
      end

      context "when the record doesn't exist" do
        let!(:req) { get :index, q: "example record" }

        it "returns a status code 404" do
          expect(response).to have_http_status(404)
        end

        it "returns a message" do
          expect(json["message"]).
            to match(/Sorry, example record not found./)
        end
      end
    end
  end

  describe 'GET #show' do
    let!(:req) { get :show, id: bucketlist.id }

    it "returns a status code 200" do
      expect(response).to have_http_status(200)
    end

    it "assigns bucketlist to @bucketlist" do
      expect(assigns(:bucketlist)).to eq(bucketlist)
    end

    it "shows a bucketlist" do
      expect(json["name"]).to eq(bucketlist.name)
    end
  end

  describe 'POST #create' do
    let(:bucketlist) { build(:bucketlist) }

    context "when valid request" do
      let!(:req) { post :create, name: bucketlist.name, created_by: user.id }

      it "returns a status code 201" do
        expect(response).to have_http_status(201)
      end

      it "creates a new bucketlist" do
        expect(Bucketlist.all.size).to eq(1)
      end
    end

    context "when invalid request" do
      let!(:req) { post :create, name: nil, created_by: user.id }

      it "returns a status code 422" do
        expect(response).to have_http_status(422)
      end

      it "does not create a new bucketlist" do
        expect(Bucketlist.all.size).to eq(0)
      end
    end
  end

  describe 'GET #show' do
    it "retrieves a bucketlist" do
      get :show, id: bucketlist.id
      expect(json["name"]).to eq(bucketlist.name)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT #update' do
    it "updates a bucketlist" do
      put :update, id: bucketlist.id, name: "Mozart"
      updated_bucketlist = Bucketlist.find(bucketlist.id)
      expect(updated_bucketlist.name).to eq("Mozart")
      expect(response).to have_http_status(204)
    end
  end

  describe 'DELETE #destroy' do
    let!(:bucketlists) { create_list(:bucketlist, 5) }

    it "deletes a bucketlist" do
      expect do
        delete :destroy, id: bucketlists.last.id
      end.to change(Bucketlist, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end

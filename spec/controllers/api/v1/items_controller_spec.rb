require "rails_helper"

RSpec.describe API::V1::ItemsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:bucketlist) { create(:bucketlist, created_by: user.id) }
  let!(:item) { create(:item, bucketlist_id: bucketlist.id) }
  let!(:headers) { set_headers }

  before { allow(request).to receive(:headers).and_return(headers) }

  it_behaves_like "an api controller", bucketlist_id: "foo", id: "bar"

  describe "GET #index" do
    before { get :index, bucketlist_id: bucketlist.id }

    it "retuns the bucketlist items" do
      expect(json.size).to eq(1)
      expect(json.first["name"]).to eq(item.name)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    before { get :show, bucketlist_id: bucketlist.id, id: item.id }

    it "retuns the bucketlist item" do
      expect(json["name"]).to eq(item.name)
    end
  end

  describe "POST #create" do
    it "creates a new item" do
      expect do
        post :create, item_valid_atrr
      end.to change(Item, :count).by(1)
      expect(response).to have_http_status(201)
    end
  end

  describe "PUT #update" do
    it "updates a record" do
      put :update, bucketlist_id: bucketlist.id, id: item.id, name: "Chopin"
      updated_item = Item.find(item.id)
      expect(updated_item.name).to eq("Chopin")
      expect(response).to have_http_status(201)
    end
  end

  describe "DELETE #destroy" do
    let!(:new_item) { create(:item, bucketlist_id: bucketlist.id) }

    it "deletes an item" do
      expect do
        delete :destroy, bucketlist_id: bucketlist.id, id: new_item.id
      end.to change(Item, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end

  def item_valid_atrr
    attributes_for(:item, bucketlist_id: bucketlist.id)
  end
end

require "rails_helper"

RSpec.describe "Items API" do
  let!(:user) { create(:user) }
  let!(:bucketlist) { create(:bucketlist, created_by: user.id) }
  let!(:items) { create_list(:item, 20, bucketlist_id: bucketlist.id) }
  let(:bucketlist_id) { bucketlist.id }
  let(:id) { items.first.id }
  let!(:headers) { set_headers }
  let!(:invalid_headers) { set_invalid_headers }

  describe "GET /bucketlists/:bucketlist_id/items" do
    context "when authentication token is passed" do
      let!(:req) { get "/bucketlists/#{bucketlist_id}/items", {}, headers }

      context "when bucketlist exists" do
        it_behaves_like "a http response", 200
        it_behaves_like "a schema", "item"

        it "returns all bucketlist items" do
          expect(json.size).to eq(20)
        end
      end

      context "when bucketlist does not exist" do
        let(:bucketlist_id) { 0 }

        it_behaves_like "a http response", 404, /Couldn't find Bucketlist/
      end
    end

    include_context "unauthenticated request" do
      before { get "/bucketlists/#{bucketlist_id}/items", {}, invalid_headers }
    end
  end

  describe "GET /bucketlists/:bucketlist_id/items/:id" do
    context "when authentication token is passed" do
      let!(:req) do
        get "/bucketlists/#{bucketlist_id}/items/#{id}", {}, headers
      end

      context "when bucketlist item exists" do
        it_behaves_like "a http response", 200
        it_behaves_like "a schema", "item"

        it "returns the item" do
          expect(json["id"]).to eq(id)
        end
      end

      context "when bucketlist item does not exist" do
        let(:id) { 0 }

        it_behaves_like "a http response", 404, /Couldn't find Item/
      end
    end

    include_context "unauthenticated request" do
      before do
        get "/bucketlists/#{bucketlist_id}/items/#{id}", {}, invalid_headers
      end
    end
  end

  describe "POST /bucketlists/:bucketlist_id/items" do
    let(:valid_attributes) { { name: "Visit Narnia" }.to_json }

    context "when an authentication token is passed" do
      context "when a valid request" do
        let!(:req) do
          post "/bucketlists/#{bucketlist_id}/items", valid_attributes,
               headers
        end

        it_behaves_like "a http response", 201
        it_behaves_like "a schema", "bucketlist"
      end

      context "when an invalid request" do
        let!(:req) do
          post "/bucketlists/#{bucketlist_id}/items", {}, headers
        end

        it_behaves_like "a http response", 422,
                        /Validation failed: Name can't be blank/
      end
    end

    include_context "unauthenticated request" do
      before do
        post "/bucketlists/#{bucketlist_id}/items", valid_attributes,
             invalid_headers
      end
    end
  end

  describe "PUT /bucketlists/:bucketlist_id/items/:id" do
    let(:valid_attributes) { { name: "Mozart" }.to_json }

    context "when an authentication token is passed" do
      let!(:req) do
        put "/bucketlists/#{bucketlist_id}/items/#{id}", valid_attributes,
            headers
      end

      context "when item exists" do
        it_behaves_like "a http response", 201

        it "updates the item" do
          updated_item = Item.find(id)
          expect(updated_item.name).to match(/Mozart/)
        end
      end

      context "when item does not exist" do
        let(:id) { 0 }

        it_behaves_like "a http response", 404, /Couldn't find Item/
      end
    end

    include_context "unauthenticated request" do
      before do
        put "/bucketlists/#{bucketlist_id}/items/#{id}", valid_attributes,
            invalid_headers
      end
    end
  end

  describe "DELETE /bucketlists/:id" do
    context "when an authentication token is passed" do
      let!(:req) do
        delete "/bucketlists/#{bucketlist_id}/items/#{id}", {}, headers
      end

      it_behaves_like "a http response", 204
    end

    include_context "unauthenticated request" do
      before do
        delete "/bucketlists/#{bucketlist_id}/items/#{id}", {},
               invalid_headers
      end
    end
  end
end

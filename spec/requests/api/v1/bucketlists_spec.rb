require "rails_helper"

RSpec.describe "Bucketlists API", type: :request do
  let(:user) { create(:user) }
  let!(:bucketlists) { create_list(:bucketlist, 200, created_by: user.id) }
  let!(:headers) { set_headers }
  let!(:invalid_headers) { set_invalid_headers }

  describe "GET /bucketlists" do
    context "when an authorization token is passed" do
      context "when pagination is specified" do
        it_behaves_like "a paginable resource", page: 1, limit: 50
        it_behaves_like "a paginable resource", page: 3, limit: 50
        it_behaves_like "a paginable resource", page: 2, limit: 120

        context "when query string is present" do
          let!(:bucketlist) do
            create(:bucketlist, name: "FooBar", created_by: user.id)
          end

          context "when the record exists" do
            let!(:req) { get "/bucketlists", { q: bucketlist.name }, headers }

            it_behaves_like "a http response", 200
            it_behaves_like "a schema", "bucketlist"

            it "returns bucketlists" do
              expect(json).not_to be_empty
              expect(json.first["name"]).to eq(bucketlist.name)
            end
          end

          context "when the record does not exist" do
            let!(:req) { get "/bucketlists", { q: "example record" }, headers }

            it_behaves_like "a http response", 404,
                            /Sorry, example record not found/
          end
        end
      end

      context "when pagination is not specified" do
        let!(:req) { get "/bucketlists", {}, headers }

        it_behaves_like "a http response", 200
        it_behaves_like "a schema", "bucketlist"

        it "returns first 20 bucketlists" do
          expect(json.size).to eq(20)
        end
      end
    end
  end

  include_context "unauthenticated request" do
    before { get "/bucketlists", {}, invalid_headers }
  end

  describe "GET /bucketlists/:id" do
    let(:id) { bucketlists.first.id }

    context "when an authorization token is passed" do
      let!(:req) { get "/bucketlists/#{id}", {}, headers }

      context "when bucketlist exists" do
        it_behaves_like "a http response", 200
        it_behaves_like "a schema", "bucketlist"

        it "returns the bucketlist" do
          expect(json).not_to be_empty
          expect(json["id"]).to eq(bucketlists.first.id)
        end
      end

      context "when bucketlist does not exist" do
        let(:id) { 0 }

        it_behaves_like "a http response", 404, /Couldn't find Bucketlist/
      end
    end

    include_context "unauthenticated request" do
      before { get "/bucketlists/#{id}", {}, invalid_headers }
    end
  end

  describe "POST /bucketlists" do
    let(:valid_attributes) { { name: "Visit Narnia" }.to_json }

    context "when an authentication token is passed" do
      context "when a valid request" do
        let!(:req) { post "/bucketlists", valid_attributes, headers }

        it_behaves_like "a http response", 201
        it_behaves_like "a schema", "bucketlist"

        it "returns the created bucketlist" do
          expect(json["name"]).to match(/Visit Narnia/)
        end
      end

      context "when an invalid request" do
        let!(:req) { post "/bucketlists", {}, headers }

        it_behaves_like "a http response", 422,
                        /Validation failed: Name can't be blank/
      end
    end

    include_context "unauthenticated request" do
      before { post "/bucketlists", valid_attributes, invalid_headers }
    end
  end

  describe "PUT /bucketlists/:id" do
    let(:id) { bucketlists.first.id }
    let(:valid_attributes) { { name: "Mozart" }.to_json }

    context "when an authentication token is passed" do
      let!(:req) { put "/bucketlists/#{id}", valid_attributes, headers }

      context "when bucketlist exists" do
        it_behaves_like "a http response", 204

        it "updates the bucketlist" do
          updated_bucketlist = Bucketlist.find(id)
          expect(updated_bucketlist.name).to match(/Mozart/)
        end
      end

      context "when bucketlist does not exist" do
        let(:id) { 0 }

        it_behaves_like "a http response", 404, /Couldn't find Bucketlist/
      end
    end

    include_context "unauthenticated request" do
      before { put "/bucketlists/#{id}", valid_attributes, invalid_headers }
    end
  end

  describe "DELETE /bucketlists/:id" do
    let(:id) { bucketlists.last.id }

    context "when an authentication token is passed" do
      let!(:req) { delete "/bucketlists/#{id}", {}, headers }

      it_behaves_like "a http response", 204
    end

    include_context "unauthenticated request" do
      before { delete "/bucketlists/#{id}", {}, invalid_headers }
    end
  end
end

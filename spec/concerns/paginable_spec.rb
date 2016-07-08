require "rails_helper"

RSpec.shared_examples_for "paginable" do
  let(:model) { described_class }
  let!(:bucketlists) { create_list(:bucketlist, 10) }

  context "when page 1" do
    it "returns paginated records" do
      results = model.paginate({page: 1, limit: 5})
      expect(results.size).to eq(5)
      expect(results.first).to eq(Bucketlist.first)
    end
  end

  context "when page 2" do
    it "returns paginated records" do
      results = model.paginate({page: 2, limit: 5})
      expect(results.size).to eq(5)
      expect(results.first).to eq(Bucketlist.all[5])
    end
  end
end

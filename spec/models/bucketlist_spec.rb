require "rails_helper"
require Rails.root.join "spec/concerns/paginable.rb"

RSpec.describe Bucketlist, type: :model do
  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:user).with_foreign_key("created_by") }

  it_behaves_like "paginable"

  describe ".search" do
    let!(:bucketlist) { create(:bucketlist, name: "Mordor") }
    let!(:bucketlists) { create_list(:bucketlist, 5) }

    context "when query exists" do
      it "finds the bucketlist" do
        results = described_class.search("mordor")
        expect(results).not_to be_empty
        expect(results).to include(bucketlist)
      end
    end

    context "when query does not exist" do
      it "raises ActiveRecord::RecordNotFound error" do
        expect { described_class.search("ffff") }.
          to raise_error(ActiveRecord::RecordNotFound, /fff not found/)
      end
    end
  end
end

require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  it { should have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:user).with_foreign_key('created_by') }
end

require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  it { is_expected.to have_many(:items).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end

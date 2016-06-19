require 'rails_helper'

RSpec.describe Item, type: :model do
  it { is_expected.to belong_to(:bucket_list) }
  it { should validate_presence_of(:name) }
end

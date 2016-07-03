require 'rails_helper'

RSpec.describe User, type: :model do
it { should have_many(:bucketlists).with_foreign_key('created_by') }
it { should validate_presence_of(:firstname) }
it { should validate_presence_of(:lastname) }
it { should validate_presence_of(:email) }
it { should validate_presence_of(:password_digest) }
end

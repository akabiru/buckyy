require "rails_helper"

RSpec.describe InvalidToken, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:token) }
  it do
    should validate_uniqueness_of(:token).
      with_message("has already been logged out.")
  end
end

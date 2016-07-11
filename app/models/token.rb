class Token < ActiveRecord::Base
  belongs_to :user
  validates :token,
            presence: true,
            uniqueness: { message: "has already been logged out." }
end

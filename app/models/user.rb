class User < ActiveRecord::Base
  has_many :bucketlists, foreign_key: :created_by
  has_secure_password

  validates_presence_of :firstname, :lastname, :email, :password_digest
end

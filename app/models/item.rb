class Item < ActiveRecord::Base
  belongs_to :bucketlist
  validates_presence_of :name
end

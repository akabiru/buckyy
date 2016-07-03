class Bucketlist < ActiveRecord::Base
  has_many :items, dependent: :destroy
  belongs_to :user, foreign_key: :created_by
  validates_presence_of :name

  def self.search!(name)
    bucketlist = where("name ILIKE ?", "#{name}%")
    raise(
      ActiveRecord::RecordNotFound, Message.not_found(name)
    ) if bucketlist.blank?
    bucketlist
  end
end

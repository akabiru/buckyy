class Bucketlist < ActiveRecord::Base
  extend Paginate

  has_many :items, dependent: :destroy
  validates_presence_of :name

  def self.search!(name)
    bucketlist = where("name ILIKE ?", "#{name}%")
    raise(
      ActiveRecord::RecordNotFound, Message.not_found(name)
    ) if bucketlist.blank?
    bucketlist
  end
end

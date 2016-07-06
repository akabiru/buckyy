class Bucketlist < ActiveRecord::Base
  extend Paginate

  has_many :items, dependent: :destroy
  belongs_to :user, foreign_key: :created_by
  validates_presence_of :name

  def self.search(name)
    bucketlists = where("name ILIKE ?", "#{name}%")
    raise(
      ActiveRecord::RecordNotFound, Message.not_found(name)
    ) if bucketlists.blank?
    bucketlists
  end
end

class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_by

  has_many :items
end

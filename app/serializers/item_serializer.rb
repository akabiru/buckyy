class ItemSerializer < ActiveModel::Serializer
  include Utilities
  attributes :id, :name, :done, :date_created, :date_modified
end

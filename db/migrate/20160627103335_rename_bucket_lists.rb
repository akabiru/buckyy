class RenameBucketLists < ActiveRecord::Migration
  def change
    rename_table :bucket_lists, :bucketlists
    rename_column :items, :bucket_list_id, :bucketlist_id
  end
end

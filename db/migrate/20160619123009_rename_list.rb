class RenameList < ActiveRecord::Migration
  def change
    rename_table :lists, :bucket_lists
    rename_column :items, :list_id, :bucket_list_id
  end
end

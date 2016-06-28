class ChangeItem < ActiveRecord::Migration
  def change
    change_column :items, :done, :boolean, null: false, default: false
  end
end

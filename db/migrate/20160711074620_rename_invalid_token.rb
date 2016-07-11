class RenameInvalidToken < ActiveRecord::Migration
  def change
    rename_table :invalid_tokens, :tokens
  end
end

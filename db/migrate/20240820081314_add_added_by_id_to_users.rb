class AddAddedByIdToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :added_by_id, :bigint
  end

  def down
    remove_column :users, :added_by_id
  end
end

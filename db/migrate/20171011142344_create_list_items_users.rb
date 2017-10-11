class CreateListItemsUsers < ActiveRecord::Migration
  def change
    create_join_table :list_items, :users
  end
end

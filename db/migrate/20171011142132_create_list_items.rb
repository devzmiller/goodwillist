class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string :keywords, null: false, unique: true
      t.timestamps null: false
    end
  end
end

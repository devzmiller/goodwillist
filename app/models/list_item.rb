class ListItem < ActiveRecord::Base
  has_many :list_items_users
  has_many :users, through: :list_items_users
end

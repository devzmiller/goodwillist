class ListItemsUser < ActiveRecord::Base
  belongs_to :list_item
  belongs_to :user
end

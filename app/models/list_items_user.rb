class ListItemsUser < ApplicationRecord
  belongs_to :list_item
  belongs_to :user
end

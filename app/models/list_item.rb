class ListItem < ApplicationRecord
  has_many :list_items_users, dependent: :destroy
  has_many :users, through: :list_items_users

  def get_user_count
    self.users.length
  end
end

class ListItem < ApplicationRecord
  has_and_belongs_to_many :users

  def get_user_count
    self.users.length
  end
end

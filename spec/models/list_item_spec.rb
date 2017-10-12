require 'spec_helper'

describe ListItem do
  let!(:user) { User.create!(name: "Marguerite Fish", email: "fish@llama.com", password: "ham")}
  let!(:user2) { User.create!(name: "Georgina Fish", email: "georgina@llama.com", password: "ham")}
  let!(:item) { ListItem.create!(keywords: "The Hobbit")}
  describe 'associations' do
    it 'has many users' do
      user.list_items << item
      user2.list_items << item
      expect(item.users).to include(user).and include(user2)
    end
  end
  describe '#get_user_count' do
    it 'it returns the number of users who are associated with an item' do
      user.list_items << item
      expect(item.get_user_count).to eq 1
    end
  end
end

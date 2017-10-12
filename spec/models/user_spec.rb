require 'spec_helper'

describe User do
  let!(:user) { User.create!(name: "Marguerite Fish", email: "fish@llama.com", password: "ham")}
  let!(:item) { ListItem.create!(keywords: "The Hobbit")}

  describe 'associations' do
    it 'has a list' do
      user.list_items << item
      expect(user.list_items).to all be_a ListItem
    end
  end

  describe 'validations' do
    context 'it is invalid when' do
      it 'does not have a name' do
        user.name = nil
        expect(user).to_not be_valid
      end
      it 'does not have an email' do
        user.email = nil
        expect(user).to_not be_valid
      end
      it 'has a non-unique email' do
        user2 = User.new(name: "Marguerite Fish", email: "fish@llama.com", password: "ham")
        expect(user2).to_not be_valid
      end
      it 'does not have a password_hash' do
        user.password_hash = nil
        expect(user).to_not be_valid
      end
    end
    context 'it is valid when' do
      it 'has a name, email, and password_hash' do
        expect(user).to be_valid
      end
    end
  end

  describe 'authentication' do
    it 'has a hashed password' do
      expect(user.password_hash).to_not eq "ham"
    end
    it 'returns the user when they correctly authenticate' do
      expect(User.authenticate("fish@llama.com", "ham")).to eq user
    end
    it 'returns nil when the user enters an email which does not exist in the database' do
      expect(User.authenticate("marvin@ham.com", "ham")).to be_nil
    end
    it 'returns nil when the password does not match' do
      expect(User.authenticate("fish@llama.com", "spam")).to be_nil
    end
  end

end

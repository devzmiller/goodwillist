require 'spec_helper'

describe "ListItemsController" do
  let!(:user) { User.create!(name: "Marguerite Fish", email: "fish@llama.com", password: "ham")}
  let!(:item) { ListItem.create!(keywords: "The Hobbit")}

  describe 'creating a new list item' do
    context 'get /list_items/new' do
      it 'returns OK status' do
        get "/user/#{user.id}/list_items/new"
        expect(last_response).to be_ok
      end
    end
    context 'post /list_items' do
      before(:each) do
        post "/users/#{user.id}/list_items", {keywords: "The Hobbit"}
      end
      it 'returns redirect' do
        expect(last_response.redirect?).to be true
      end
      it 'redirects to user show page' do
        expect(last_response.location).to end_with "/users/#{user.id}"
      end
      it "adds the list item to the user's list" do
        expect(user.list_items.find_by_keywords("The Hobbit")).to be_a ListItem
      end
      it 'creates the new list_items' do
        expect(ListItem.find_by_keywords("The Hobbit")).to be_a ListItem
      end
    end
  end

  describe 'modifying a list item' do
    context 'get /list_items/:id/edit' do
      it 'returns OK status' do
        get "/users/#{user.id}/list_items/#{item.id}/edit"
        expect(last_response).to be_ok
      end
    end
    context 'put /list_items/:id' do
      before(:each) do
        user.list_items << item
      end
      it 'returns redirect' do
        put "/users/#{user.id}/list_items/#{item.id}", {keywords: "The Lord of the Rings"}
        expect(last_response.redirect?).to be true
      end
      it 'redirects to user show page' do
        put "/users/#{user.id}/list_items/#{item.id}", {keywords: "The Lord of the Rings"}
        expect(last_response.location).to end_with "/users/#{user.id}"
      end
      it 'modifies the existing list item if no other users are associated with it' do
        put "/users/#{user.id}/list_items/#{item.id}", {keywords: "The Lord of the Rings"}
        item.reload
        expect(item.keywords).to eq "The Lord of the Rings"
      end
      context 'other users are associated with the item' do
        let!(:user2) { User.create!(name: "Georgina Fish", email: "georgina@llama.com", password: "ham")}
        before(:each) do
          user2.list_items << item
          put "/users/#{user.id}/list_items/#{item.id}", {keywords: "Catfish"}
        end
        it 'creates a new list item and associates it with the user' do
          new_item = ListItem.find_by_keywords("Catfish")
          expect(user.list_items).to include new_item
        end
        it 'deletes the user association with the old list item' do
          user.reload
          expect(user.list_items).to_not include item
        end
        it 'does not destroy the old list item itself' do
          expect(ListItem.find_by_keywords("The Hobbit")).to eq item
        end
      end
    end
  end

  describe 'deleting a list item' do
    before(:each) do
      user.list_items << item
    end
    context 'when nobody else owns this list item' do
      before(:each) do
        delete "users/#{user.id}/list_items/#{item.id}"
      end
      it 'returns redirect' do
        expect(last_response.redirect?).to be true
      end
      it 'redirects to user show page' do
        expect(last_response.location).to end_with "/users/#{user.id}"
      end
      it "deletes the user's association with the item" do
        user.reload
        expect(user.list_items).to_not include item
      end
      it 'deletes the item from the database' do
        expect(ListItem.all).to_not include item
      end
    end
    context 'when other users own this list item' do
      let!(:user2) { User.create!(name: "Georgina Fish", email: "georgina@llama.com", password: "ham")}
      before(:each) do
        user2.list_items << item
        delete "users/#{user.id}/list_items/#{item.id}"
      end
      it "does not delete the item from the database" do
        expect(ListItem.all).to include item
      end
    end
  end
end

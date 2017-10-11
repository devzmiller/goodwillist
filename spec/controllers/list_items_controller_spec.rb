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
      it 'returns redirect'
      it 'redirects to user show page'
      context 'other users are associated with the item' do
        it 'creates a new list item and associates it with the user'
        it 'destroys the user association with the old list item'
      end
      it 'modifies the existing list item if no other users are associated with it'
    end
  end
end

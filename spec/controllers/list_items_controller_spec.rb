require 'spec_helper'

describe "ListItemsController" do
  let!(:user) { User.create!(name: "Marguerite Fish", email: "fish@llama.com", password: "ham")}
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
end

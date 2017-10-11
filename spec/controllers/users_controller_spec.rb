require 'spec_helper'

describe 'UsersController' do

  describe 'new user creation' do
    context 'get /users/new' do
      it 'returns OK status' do
        get '/users/new'
        expect(last_response).to be_ok
      end
    end
    context 'post /users' do
      before(:each) do
        post '/users', {user: {name: "Marguerite Fish", email: "fish@llama.com", password: "ham"}}
      end
      it 'redirects' do
        expect(last_response.redirect?).to be true
      end
      it 'redirects to login page' do
        expect(last_response.location).to end_with "/sessions/new"
      end
      it 'creates a new user' do
        expect(User.find_by_email("fish@llama.com")).to be_a User
      end
    end
  end
end

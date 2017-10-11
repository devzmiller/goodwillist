require 'spec_helper'

describe "SessionsController" do
  let!(:user) { User.create!(name: "Marguerite Fish", email: "fish@llama.com", password: "ham")}

  describe 'login form: /sessions/new' do
    it 'returns OK status' do
      get '/sessions/new'
      expect(last_response).to be_ok
    end
  end

  describe 'login: post /sesssions' do
    context "login is successful" do
      it 'returns redirect' do
        post '/sessions', {email: "fish@llama.com", password: "ham"}
        expect(last_response.redirect?).to be true
      end
      it 'redirects to user show page' do
        post '/sessions', {email: "fish@llama.com", password: "ham"}
        expect(last_response.location).to end_with "/users/#{user.id}"
      end
    end
    context "login fails" do
      it 'returns ok status' do
        post '/sessions', {email: "fish@llama.com", password: "spam"}
        expect(last_response).to be_ok
      end
    end
  end

  describe 'logout: delete /sessions' do
    before(:each) do
      delete "/sessions/#{user.id}", {}, "rack.session" => {user_id: user.id}
    end
    it 'returns redirect' do
      expect(last_response.redirect?).to be true
    end
    it 'redirects to root' do
      expect(last_response.location).to end_with "/"
    end
  end
end

get '/users/new' do

end

post '/users' do
  User.create(params[:user])
  redirect '/sessions/new'
end

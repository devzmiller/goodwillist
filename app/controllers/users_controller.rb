get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  User.create(params[:user])
  redirect '/sessions/new'
end

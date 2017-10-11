get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  User.create(params[:user])
  redirect '/sessions/new'
end

get '/users/:id' do
  @user = User.find(session[:user_id])
  erb :'/users/show'
end

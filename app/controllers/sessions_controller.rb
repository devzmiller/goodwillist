get '/sessions/new' do

end

post '/sessions' do
  user = User.authenticate(params[:email], params[:password])
  if user == nil
    @error = "Invalid username or password"
    erb :'/sessions/new'
  else
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  end
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
end

get '/list_items/new' do
  erb :'/list_items/new'
end

post '/user/:user_id/list_items' do
  @list_item = ListItem.find_or_create_by(keywords: params[:keywords])
  @user = User.find(params[:user_id])
  @user.list_items << @list_item
  redirect "/user/#{@user.id}"
end

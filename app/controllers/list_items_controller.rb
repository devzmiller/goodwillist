get '/user/:user_id/list_items/new' do
  @user = User.find(params[:user_id])
  erb :'/list_items/new'
end

post '/users/:user_id/list_items' do
  @list_item = ListItem.find_or_create_by(keywords: params[:keywords])
  @user = User.find(params[:user_id])
  @user.list_items << @list_item
  redirect "/users/#{@user.id}"
end

get '/users/:user_id/list_items/:id/edit' do
  @list_item = ListItem.find(params[:id])
  @user = User.find(params[:user_id])
  erb :'/list_items/edit'
end

put '/users/:user_id/list_items/:id' do
  list_item = ListItem.find(params[:id])
  if list_item.get_user_count > 1
    new_item = ListItem.create(keywords: params[:keywords])
    user = User.find(params[:user_id])
    user.list_items << new_item
    user.list_items.destroy(list_item)
    user.save
    redirect "/users/#{params[:user_id]}"
  else
    list_item.update(keywords: params[:keywords])
    redirect "/users/#{params[:user_id]}"
  end
end

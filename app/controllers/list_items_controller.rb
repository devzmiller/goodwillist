get '/users/:user_id/list_items/new' do
  # if session[:user_id] == params[:user_id]
    @user = User.find(params[:user_id])
    erb :'/list_items/new'
  # else
  #   status 404
  #   erb :'/404'
  # end
end

post '/users/:user_id/list_items' do
  # if session[:user_id] == params[:user_id]
    @list_item = ListItem.find_or_create_by(keywords: params[:keywords])
    @user = User.find(params[:user_id])
    @user.list_items << @list_item
    redirect "/users/#{@user.id}"
  # else
  #   status 404
  #   erb :'/404'
  # end
end

get '/users/:user_id/list_items/:id/edit' do
  if session[:user_id] == params[:user_id]
    @list_item = ListItem.find(params[:id])
    @user = User.find(params[:user_id])
    erb :'/list_items/edit'
  else
    status 404
    erb :'/404'
  end
end

put '/users/:user_id/list_items/:id' do
  if session[:user_id] == params[:user_id]
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
  else
    status 404
    erb :'/404'
  end
end

delete '/users/:user_id/list_items/:id' do
  if session[:user_id] == params[:user_id]
    list_item = ListItem.find(params[:id])
    user = User.find(params[:user_id])
    if list_item.get_user_count > 1
      user.list_items.destroy(list_item)
      user.save
      redirect "/users/#{params[:user_id]}"
    else
      list_item.destroy
      redirect "/users/#{params[:user_id]}"
    end
  else
    status 404
    erb :'/404'
  end
end

get '/users/:user_id/inventory' do
    @user = User.find(params[:user_id])
    @keywords = []
    @user.list_items.each do |item|
      @keywords << item.keywords.gsub(" ", "%20")
    end
    @api_urls = []
    @keywords.each do |keyword|
      url = "http://svcs.ebay.com/services/search/FindingService/v1"
      url += "?OPERATION-NAME=findItemsIneBayStores"
      url += "&SERVICE-VERSION=1.0.0"
      url += "&SECURITY-APPNAME=#{ENV["EBAY_ID"]}"
      url += "&GLOBAL-ID=EBAY-US"
      url += "&RESPONSE-DATA-FORMAT=JSON"
      url += "&callback=itemHandler"
      url += "&REST-PAYLOAD"
      url += "&storeName=seattlegoodwillbooks"
      url += "&keywords=#{keyword}"
      url += "&paginationInput.entriesPerPage=3"
      @api_urls << url
    end
  erb :'/inventory_items/show'
end

get '/keywords' do
  @user = User.find(session[:user_id])
  @list_items = @user.list_items
  @keywords = []
  @list_items.each do |item|
    @keywords << item.keywords
  end
  content_type 'application/json'
  @keywords.to_json
end

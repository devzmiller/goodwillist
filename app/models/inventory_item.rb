class InventoryItem < ActiveRecord::Base[5.0]

  def self.get_ebay_inventory
    url = "http://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsIneBayStores&SERVICE-VERSION=1.13.0&SECURITY-APPNAME=#{ENV['EBAY_ID']}&GLOBAL-ID=EBAY-US&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD&storeName=seattlegoodwillbooks&paginationInput.entriesPerPage=100"
    response = RestClient.get(url)
    JSON.parse(response.body[16..-2], symbolize_names: true)
  end

def self.parse_json_item(json_item)
  InventoryItem.create(title: json_item[:title][0],
  url: json_item[:viewItemURL][0],
  image_url: json_item[:galleryURL][0],
  condition: json_item[:condition][0][:conditionDisplayName][0],
  ebay_item_num: json_item[:itemId][0])
end

def self.parse_all_json(json)
  json[:findItemsIneBayStoresResponse][0][:searchResult][0][:item].each do |item|
    parse_json_item(item)
  end
end

end

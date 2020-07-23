class StoreStock
  def initialize
    @url = 'http://test.jp/'
    @name = "Store Stock"
  end
  def get_stock_from_store_api
    uri = URI.parse(@url)
    #response = Net::HTTP.post_form(uri, rows.to_json)
  end
end

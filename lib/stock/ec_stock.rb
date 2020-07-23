class ECStock
  def initialize
    @url = 'http://test.jp/'
  end
  def get_stock_from_api
    uri = URI.parse(@url)
    #response = Net::HTTP.post_form(uri, rows.to_json)
    # response.to_json
  end
end
require "#{Rails.root}/lib/stock/ec_stock.rb"
require "#{Rails.root}/lib/stock/store_stock.rb"
require "#{Rails.root}/lib/stock/ec_stock_adapter.rb"

# require "#{Rails.root}/lib/stock/stock_client_proxy.rb"
# デフォルトの処理
# 今まで通りに店舗在庫を取得する
# default_client = StockClient.new
# store_amount = default_client.get_stock(1)
# 引数にEC在庫を指定するとインターフェイスを変更せずにEC在庫を取得する
# default_client = StockClient.new(EcStockAdapter.new(ECStock.new))
# ec_amount = default_client.get_stock(3)
class StockClientProxy
  class StockClientProxyAuthenticationError < StandardError; end
  def initialize(account, store_stock=nil)
    store_stock ||= StoreStock.new
    @store_stock = store_stock
    @local_logger = AnyLogger.instance
    raise StockClientProxyAuthenticationError unless account.account_type == "system"
  end
  def get_stock(id)
    add_operation_log
    @store_stock.get_stock_from_store_api(id)
  end
  def add_operation_log
    @local_logger.add_logs('Stock API Log', "Call #{@store_stock.name}", Account.system, Operation.dashboard)
  end
end
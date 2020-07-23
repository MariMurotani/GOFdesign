require 'singleton'
require "#{Rails.root}/lib/stock/store_stock.rb"
require "#{Rails.root}/lib/stock/ec_stock.rb"
require "#{Rails.root}/lib/stock/stock_adapter.rb"

def StockClient
  def initialize(store_stock=nil)
    store_stock ||= StoreStock.new
    @store_stock = store_stock
  end
  def get_stock
    @store_stock.get_stock_from_store_api
    add_operation_log
  end
  def add_operation_log
    @@logger.add_logs("Call #{@store_stock.name}", Account.system, Operation.dashboard)
  end
end

# デフォルトの処理
# 今まで通りに店舗在庫を取得する
default_client = StockClient.new
default_client.get_stock

# 引数にEC在庫を指定するとインターフェイスを変更せずにEC在庫を取得する
default_client = StockClient.new(ECClient)
default_client.get_stock
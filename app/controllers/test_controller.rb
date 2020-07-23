require "#{Rails.root}/lib/stock/stock_client.rb"
class TestController < ApplicationController
  def index
    logger2 = AnyLogger.instance
    @@logger.add_logs('test','This is test for flush logs', Account.system, Operation.dashboard)
    render json: {logger1: @@logger.object_id, logger2: logger2.object_id}, status: 200
  end

  def get_stock_list
    # デフォルトの処理
    # 今まで通りに店舗在庫を取得する
    default_client = StockClient.new
    store_amount = default_client.get_stock(1)
    # 引数にEC在庫を指定するとインターフェイスを変更せずにEC在庫を取得する
    default_client = StockClient.new(EcStockAdapter.new(ECStock.new))
    ec_amount = default_client.get_stock(3)
    render json: {store_amount: store_amount, ec_amount: ec_amount}, status: 200
  end
end

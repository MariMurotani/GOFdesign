class StockClientProxy
  class StockClientProxyAuthenticationError < StandardError; end
  def initialize(account, store_stock=nil)
    store_stock ||= StoreStockClient.new
    @store_stock = store_stock
    @local_logger = AnyLogger.instance
    raise StockClientProxyAuthenticationError unless account.account_type == "system"
  end
  def get_stock(id)
    add_operation_log
    @store_stock.get_stock_from_store_api(id)
  end
  def add_operation_log
    @local_logger.add_logs('Stock API Log', "Call #{@store_stock.name}", Account.system_user, Operation.dashboard)
  end
end
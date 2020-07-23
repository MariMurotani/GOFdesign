class ECStockAdapter < StoreStock
  def intialize(ecs)
    @ecs = ecs
    @name = "EC Stock"
  end
  def get_stock_from_store_api
    @ecs.get_stock_from_api
  end
end
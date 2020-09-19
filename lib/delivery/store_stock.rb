module Delivery
  class StoreStock < Step
    def initialize
      super
      @name = "店舗在庫取得時間"
    end
    def get_time_required
      3
    end
  end
end
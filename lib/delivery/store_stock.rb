class StoreStock < Step
  def initialize
    @name = "店舗在庫取得時間"
  end
  def get_time_required
    1
  end
end
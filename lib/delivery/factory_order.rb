class FactoryOrder < Step
  def initialize
    @name = "商品工場発注時間"
  end
  def get_time_required
    5
  end
end
class DeliveryKanto < Step
  def initialize
    @name = "関東への配送時間"
  end
  def get_time_required
    2
  end
end
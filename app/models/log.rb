class Log < ApplicationRecord
  has_one :operation
  def initialize(*)
    super
    self.created_at = Time.zone.now
  end
end

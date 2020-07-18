class Log < ApplicationRecord
  has_many :operation

  def initialize(*)
    super
    self.created_at = Time.zone.now
  end
end

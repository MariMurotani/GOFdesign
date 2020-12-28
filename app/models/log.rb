class Log < ApplicationRecord
  belongs_to :operation
  def initialize(*)
    super
    self.created_at = Time.zone.now
  end
end

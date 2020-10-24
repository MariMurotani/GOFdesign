class Operation < ApplicationRecord
  has_many :log
  enum sub_types: {systemadmin:0, admin:1 ,user: 2}
  scope :dashboard, -> { where({sub_type: 1}).last }
end

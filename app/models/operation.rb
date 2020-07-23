class Operation < ApplicationRecord
  has_one :log
  enum sub_types: {system:0, admin:1 ,user: 2}
  scope :dashboard, -> { where({name: "admin dashboard"}).last }
end

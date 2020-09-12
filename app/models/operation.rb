class Operation < ApplicationRecord
  has_many :log
  enum sub_types: {system:0, admin:1 ,user: 2}
  scope :dashboard, -> { where({name: "admin dashboard"}).last }
end

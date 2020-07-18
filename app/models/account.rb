class Account < ApplicationRecord
  belongs_to :order
  has_many :address, dependent :destroy
end

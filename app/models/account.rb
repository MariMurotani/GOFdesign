class Account < ApplicationRecord
  has_one :order
  has_many :address, dependent: :destroy
  enum accuont_types: { administrator: 0, shopper: 1 }

  def self.create_user(target)
    case target
    when 'ADMIN'
      self.new({account_type: 0})
    when 'SHOPPER'
      self.new({account_type: 1})
    end
  end
end
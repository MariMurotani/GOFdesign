class Account < ApplicationRecord
  include ActiveModel::Serialization
  has_many :oreders
  has_one :account_rank, dependent: :destroy
  has_many :addresses, dependent: :destroy
  enum account_type: { systemadmin: 0, administrator: 1, shopper: 2 }
  scope :system_user, -> { where({account_type: :systemadmin}).last }

  def attributes
    {
      'id': nil,
      'name': nil
    }
  end
end

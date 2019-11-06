class Address < ApplicationRecord

  validates_presence_of :nickname,
                        :name,
                        :address,
                        :city,
                        :state,
                        :zip
  belongs_to :user
  has_many :orders
end

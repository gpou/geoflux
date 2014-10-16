class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :estimate_item

  validates :order_id, :presence => true
end
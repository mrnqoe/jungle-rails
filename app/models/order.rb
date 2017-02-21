class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :ordercomplete

  def ordercomplete
    # puts '=================================='
    # order_id = self.id
    # puts order_id
    # lineItem = LineItem.find_by(order_id: order_id)
    # puts lineItem
    # puts '=================================='
    self.line_items.each do |item|
      @product = item.product
      @product.decrement!('quantity', by = item.quantity)
    end
  end

end

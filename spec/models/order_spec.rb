
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category1 = Category.new(name:'Pants')
      @q01 = 100
      @q02 = 200
      @q03 = 300
      @product1 = Product.create!(name:'dude' , price: 1000, quantity: @q01, category: @category1)
      @product2 = Product.create!(name:'jimbo' , price: 1000, quantity: @q02, category: @category1)
      @product3 = Product.create!(name:'shark' , price: 100, quantity: @q03, category: @category1)
      # Setup at least one product that will NOT be in the order
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: 'wtv@wtv.vom',
        stripe_charge_id: 'test',
        total_cents: 0
      )
      # 2. build line items on @order
      @q1 = 3
      @order.line_items.new(
        product: @product1,
        quantity: @q1,
        item_price: @product1.price_cents,
        total_price: @product1.price_cents * @q1
      )

      @q2 = 2
      @order.line_items.new(
        product: @product2,
        quantity: @q2,
        item_price: @product2.price_cents,
        total_price: @product2.price_cents * @q2
      )

      # @order.line_items.each do |item|
      #   @order.total_cents += item.total_price
      # end

      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!

      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      puts @product1.quantity
      puts @product2.quantity
      puts @order.inspect

      # 5. use RSpec expect syntax to assert their new quantity values

      expect(@product1.quantity).to eq(@q01- @q1)
      expect(@product2.quantity).to eq(@q02 - @q2)
      expect(@product3.quantity).to eq(@q03)
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do

      @order = Order.new(
        email: 'wtv@wtv.vom',
        stripe_charge_id: 'test',
        total_cents: 0
      )

      @q3 = 3
      @order.line_items.new(
        product: @product3,
        quantity: @q3,
        item_price: @product3.price_cents,
        total_price: @product3.price_cents * @q3
      )

      # @order.line_items.each do |item|
      #   @order.total_cents += item.total_price
      # end

      @product3.reload
      puts @product3.quantity
      puts @order.inspect

      expect(@product3.quantity).to eq(@q03)
    end
  end
end

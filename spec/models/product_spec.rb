require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category1 = Category.new(name:'Pants')
      @product = Product.new(
      name:'card',
      price_cents:300,
      quantity:30,
      category:@category1)
      # @product.name = "a valid product name"
    end
    it "Initial product should be valid" do
      expect(@product).to be_valid
      puts @product.errors.messages.inspect
      expect(@product.errors.messages == nil)
    end
    it "should require a product name" do
      @product.name = nil
      expect(@product).to be_invalid
      expect(@product.errors.messages[:name][0] == "can't be blank")
    end
    it "should require a valid category" do
      @product.category = nil
      expect(@product).to be_invalid
      expect(@product.errors.messages[:category][0] == "can't be blank")
    end
    it "should require a product price" do
      @product.price_cents = nil
      expect(@product).to be_invalid
      expect(@product.errors.messages[:price_cents][0] == "is not a number")
      expect(@product.errors.messages[:price_cents][1] == "can't be blank")
    end
    it "should require a quantity" do
      @product.quantity = nil
      expect(@product).to be_invalid
      expect(@product.errors.messages[:quantity][0] == "can't be blank")
    end
  end
end

class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find_by(id: params[:id])
    @review = Review.new
  end

end

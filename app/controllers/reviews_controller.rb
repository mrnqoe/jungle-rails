class ReviewsController < ApplicationController
  before_filter :authenticate
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to controller: 'products', action: 'show', id: @review.product_id
    else
      @product.reviews.reload()
      render 'products/show'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    Review.find(params[:id]).destroy
    @product.reviews.reload()
    redirect_to :back
  end

  private
  def review_params
    params.require(:review).permit(
      :description,
      :rating)
  end

  def authenticate
    if !current_user
      redirect_to '/login'
    end
  end
end

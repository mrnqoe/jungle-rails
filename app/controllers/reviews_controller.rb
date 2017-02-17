class ReviewsController < ApplicationController
  before_filter :authenticate
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      puts 'SAVED'
      puts current_user
      redirect_to :back, notice: 'Review was Submitted !'

    else
      puts 'NOT SAVED'
      puts current_user
      @product.reviews.reload()
      render 'products/show', notice: 'there was an issue with your submission'
    end
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

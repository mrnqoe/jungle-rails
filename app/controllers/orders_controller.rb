class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)
    respond_to do |format|
      if order.valid?
        # Sends email to user when user is created.
        empty_cart!
        puts ENV['gmail_username']
        puts ENV['gmail_password']
        ExampleMailer.sample_email(order).deliver_later
        format.json { render :show, status: :created, location: order.email }
        format.html { redirect_to(order, notice: 'Your Order has been placed.') }
      else
        format.html { render :new }
        format.json { render json: order.errors, status: :unprocessable_entity }
        redirect_to cart_path, error: order.errors.full_messages.first
      end
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to cart_path, error: e.message
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def create_order(stripe_charge)
    order = Order.new(
    email: params[:stripeEmail],
    total_cents: cart_total,
    stripe_charge_id: stripe_charge.id # returned by stripe
    )
    cart.each do |product_id, details|
      if product = Product.find_by(id: product_id)
        quantity = details['quantity'].to_i
        order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
        )
      end
    end
    order.save!
    order
  end

  end

  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0
    cart.each do |product_id, details|
      if p = Product.find_by(id: product_id)
        total += p.price_cents * details['quantity'].to_i
      end
    end
    total
  end

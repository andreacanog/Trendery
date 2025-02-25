class Api::CartsController < ApplicationController
    before_action :require_logged_in
  
    # GET /api/cart
    def show
      @cart = current_cart
  
      if @cart.cart_items.any?
        render json: {
          cart_items: @cart.cart_items.includes(:product).map { |item| item.as_json(include: :product) },
          total_price: @cart.total_price
        }
      else
        render json: { message: "Your cart is empty." }, status: :ok
      end
    end
  
    # DELETE /api/cart
    def destroy
      @cart = current_cart
  
      if @cart.cart_items.destroy_all
        render json: { message: "Cart cleared successfully." }, status: :ok
      else
        render json: { error: "Failed to clear the cart." }, status: :unprocessable_entity
      end
    end
  
    private

    def current_cart
      current_user.cart || current_user.create_cart
    end
end

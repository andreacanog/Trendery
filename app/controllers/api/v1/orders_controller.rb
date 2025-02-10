class Api::OrdersController < ApplicationController
    before_action :require_logged_in
    before_action :set_order, only: [:show, :update, :destroy]
  
    # GET /api/orders
    def index
      @orders = current_user.orders.includes(order_items: :product)
      render json: @orders.as_json(include: {
        order_items: {
          include: { product: { only: [:id, :name, :price] } },
          only: [:id, :quantity, :subtotal]
        }
      })
    end
  
    # GET /api/orders/:id
    def show
      render json: @order.as_json(include: {
        order_items: {
          include: { product: { only: [:id, :name, :price] } },
          only: [:id, :quantity, :subtotal]
        }
      })
    end
  
    # POST /api/orders
    def create
      cart = current_user.cart
  
      if cart.cart_items.empty?
        return render json: { error: "Cart is empty" }, status: :unprocessable_entity
      end
  
      ActiveRecord::Base.transaction do
        @order = current_user.orders.create!(total: cart.total)
  
        cart.cart_items.each do |cart_item|
          @order.order_items.create!(
            product: cart_item.product,
            quantity: cart_item.quantity,
            subtotal: cart_item.product.price * cart_item.quantity
          )
        end
  
        cart.cart_items.destroy_all # Clear cart after order is created
      end
  
      render json: @order, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  
    # PATCH /api/orders/:id
    def update
      if @order.update(order_params)
        render json: @order
      else
        render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/orders/:id
    def destroy
      if @order.destroy
        render json: { message: "Order successfully deleted" }, status: :ok
      else
        render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_order
      @order = current_user.orders.find_by(id: params[:id])
      unless @order
        render json: { error: "Order not found" }, status: :not_found
      end
    end
  
    def order_params
      params.require(:order).permit(:status)
    end
  
    def require_logged_in
      unless logged_in?
        render json: { error: "Unauthorized access" }, status: :unauthorized
      end
    end
end

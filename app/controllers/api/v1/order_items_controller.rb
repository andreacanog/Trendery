class Api::OrderItemsController < ApplicationController
    before_action :require_logged_in
    before_action :set_order_item, only: [:show, :update, :destroy]
  
    # Note: need to revisit this create method
    def create
      ActiveRecord::Base.transaction do
        @order_item = current_cart.order_items.build(order_item_params)
        @order_item.save!
      end
    
      render json: { order_item: @order_item }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end    
  
    def show
      render json: { order_item: @order_item }
    end
  
    def update
      if @order_item.update(order_item_params)
        render json: { order_item: @order_item }
      else
        render json: { errors: @order_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @order_item.destroy
      render json: { message: 'Order item removed successfully' }, status: :ok
    end
  
    private
  
    def set_order_item
      @order_item = OrderItem.find_by(id: params[:id])
      unless @order_item
        render json: { error: "Order item not found" }, status: :not_found
      end
    end
  
    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id)
    end
end

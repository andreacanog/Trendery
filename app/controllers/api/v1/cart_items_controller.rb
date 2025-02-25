class Api::CartItemsController < ApplicationController
    before_action :require_logged_in
    before_action :set_cart_item, only: [:update, :destroy]
  
    # GET /api/cart_items
    def index
      @cart_items = current_user.cart.cart_items.includes(:product)
      render json: @cart_items.as_json(include: { product: { only: [:id, :name, :price, :stock] } })
    end
  
    # POST /api/cart_items
    def create
      ActiveRecord::Base.transaction do
        @cart_item = current_user.cart.cart_items.find_or_initialize_by(product_id: cart_item_params[:product_id])
    
        if @cart_item.new_record?
          @cart_item.quantity = cart_item_params[:quantity]
        else
          @cart_item.quantity += cart_item_params[:quantity].to_i
        end
    
        @cart_item.save!
      end
    
      render json: @cart_item, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
  
    # PATCH/PUT /api/cart_items/:id
    def update
      if @cart_item.update(cart_item_params)
        render json: @cart_item
      else
        render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/cart_items/:id
    def destroy
      if @cart_item.destroy
        render json: { message: "Item removed from cart" }, status: :ok
      else
        render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_cart_item
      @cart_item = current_user.cart.cart_items.find_by(id: params[:id])
      unless @cart_item
        render json: { error: "Cart item not found" }, status: :not_found
      end
    end
  
    def cart_item_params
      params.require(:cart_item).permit(:product_id, :quantity)
    end
  
    def require_logged_in
      unless logged_in?
        render json: { error: "Unauthorized access" }, status: :unauthorized
      end
    end
end

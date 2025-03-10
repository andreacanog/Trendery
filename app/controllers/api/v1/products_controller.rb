module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: [:show, :update, :destroy]
    
      # POST /api/v1/products
      def create
        @product = Product.new(product_params)
    
        if @product.save
          render json: { product: @product }, status: :created
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      # GET /api/v1/products/:id
      def show
        render json: { product: @product }
      end
    
      # PATCH/PUT /api/v1/products/:id
      def update
        if @product.update(product_params)
          render json: { product: @product }
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      # DELETE /api/v1/products/:id
      def destroy
        if @product.destroy
          render json: { message: "Product deleted successfully" }, status: :ok
        else
          render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      # GET /api/v1/products
      def index
        @products = Product.all
        render json: { products: @products }
      end
    
      private
    
      def set_product
        @product = Product.find_by(id: params[:id])
        unless @product
          render json: { error: "Product not found" }, status: :not_found
        end
      end
    
      def product_params
        params.require(:product).permit(:name, :description, :price, :stock, :image_url)
      end
    end
  end
end

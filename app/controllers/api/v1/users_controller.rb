module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, :require_logged_in, only: [:show, :update, :destroy]
    
      def create
        @user = User.new(user_params)
    
        if @user.save
          render json: { user: @user }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      def show
        render json: { user: @user }
      end
    
      def update
        if @user.update(user_params)
          render json: { user: @user }
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      def destroy
        if @user.destroy
          render json: { message: "User deleted successfully" }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      private
    
      def set_user
        @user = User.find_by(id: params[:id])
        unless @user
          render json: { error: "User not found" }, status: :not_found
        end
      end
    
      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    
      def require_logged_in
        unless logged_in?
          render json: { error: "Unauthorized access" }, status: :unauthorized
        end
      end
    end
  end
end

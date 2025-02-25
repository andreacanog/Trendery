class Api::SessionsController < ApplicationController
    # POST /api/session
    def create
      @user = User.find_by(email: params[:email])
  
      if @user&.authenticate(params[:password])
        login!(@user)
        render json: { user: @user }, status: :ok
      else
        render json: { error: "Invalid email or password" }, status: :unauthorized
      end
    end
  
    # DELETE /api/session
    def destroy
      if logged_in? 
        logout!
        render json: { message: "Logged out successfully" }, status: :ok
      else
        render json: { error: "No active session" }, status: :unprocessable_entity
      end
    end
end

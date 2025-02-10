class ApplicationController < ActionController::API
    include ActionController::RequestForgeryProtection
  
    # CSRF protection
    protect_from_forgery with: :exception
    before_action :snake_case_params, :attach_authenticity_token
  
    # Rescue handlers
    rescue_from StandardError, with: :unhandled_error
    rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_authenticity_token
  
    # Helper methods for authentication
    helper_method :logged_in?, :current_user
  
    def current_user
      @current_user ||= User.find_by(session_token: session[:session_token])
    end
  
    def logged_in?
      !!current_user
    end
  
    def login!(user)
      session[:session_token] = user.reset_session_token!
    end
  
    def logout!
      current_user&.reset_session_token!
      session[:session_token] = nil
      @current_user = nil
    end
  
    def require_logged_in
      render json: { message: 'Unauthorized' }, status: :unauthorized unless logged_in?
    end

    def current_cart
      return nil unless logged_in?  # Ensure user is logged in
      @current_cart ||= current_user.cart || current_user.create_cart
    end   
  
    private
  
    # Converts incoming camelCase parameters to snake_case for Rails
    def snake_case_params
      params.deep_transform_keys!(&:underscore)
    end
  
    # Attaches CSRF token in response headers for secure communication with frontend
    def attach_authenticity_token
      headers['X-CSRF-Token'] = masked_authenticity_token(session) if logged_in?
    end
  
    # Handles invalid CSRF tokens
    def invalid_authenticity_token
      render json: { message: 'Invalid authenticity token' }, status: :unprocessable_entity
    end
  
    # Handles unhandled exceptions and provides a JSON response
    def unhandled_error(error)
      if request.accepts.first.html?
        raise error
      else
        render json: { 
          message: "#{error.class} - #{error.message}",
          stack: Rails.backtrace_cleaner.clean(error.backtrace)
        }, status: :internal_server_error
  
        logger.error "\n#{error.class} (#{error.message}):\n\t#{Rails.backtrace_cleaner.clean(error.backtrace).join("\n\t")}\n"
      end
    end
end

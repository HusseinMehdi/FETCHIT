class ApplicationController < ActionController::Base
    helper_method :current_user, :admin?
  
    private
  
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    def admin?
      current_user&.email == 'admin@moguntia.com'
    end
  
    def require_admin
      unless admin?
        flash[:alert] = "Nur der Administrator kann neue Benutzer registrieren."
        redirect_to login_path
      end
    end
  end
  
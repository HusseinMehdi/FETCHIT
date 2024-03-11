class ApplicationController < ActionController::Base
  helper_method :current_user, :admin?

  private

  # Fetches the current user from the session, if present
  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  # end
  

  # # Checks if the current user is an admin
  # def admin?
  #   current_user&.email == 'admin@moguntia.com'
  # end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end
  
  def admin?
    current_user&.email == 'admin@moguntia.com'
  end
  
  
  # Ensures a user is logged in
  def require_login
    unless current_user
      flash[:alert] = "Du musst angemeldet sein, um auf diese Seite zugreifen zu können."
      redirect_to login_path
    end
  end

  # Specific checks for different roles could be defined here
  def ensure_admin
    unless admin?
      flash[:alert] = "Nur der Administrator hat Zugriff auf diesen Bereich."
      redirect_to root_path # or wherever appropriate
    end
  end
end

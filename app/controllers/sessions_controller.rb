class SessionsController < ApplicationController
  before_action :require_login, only: [:report]
  

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id  
      redirect_to report_path
    else
      flash.now[:alert] = 'Ungültige E-Mail/Passwort'
      render 'new', status: :unprocessable_entity
    end
  end
  

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Erfolgreich ausgeloggt"
  end
  


  def report
  
  end
  
  private

  def require_login
    puts "Session User ID: #{session[:user_id].inspect}" # Temporary debug output
    unless session[:user_id]
      flash[:alert] = "Du musst angemeldet sein, um auf diese Seite zugreifen zu können."
      redirect_to login_path
    end
  end
  

end

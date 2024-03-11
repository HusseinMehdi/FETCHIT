class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id  
      redirect_to new_report_path
    else
      flash.now[:alert] = 'Ungültige E-Mail/Passwort'
      render 'new', status: :unprocessable_entity
    end
  end
  

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Erfolgreich ausgeloggt"
  end
end

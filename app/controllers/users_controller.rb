class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  before_action :ensure_admin, only: [:new, :create, :destroy, :index]
  before_action :set_user, only: [:edit ,:update]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    Rails.logger.debug "Received params: #{params.inspect}"
    @user = User.new(user_params)
    if @user.save
      redirect_to new_report_path, notice: 'User registered successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update  
    #Verify current password for any update
    unless @user.authenticate(params[:user][:current_password])
      flash[:alert] = 'Wrong password'
      return render :edit, status: :unprocessable_entity
    end
         
    # Handle password change
    if params[:user][:password].present?
      # Ensure password confirmation matches new password
      unless params[:user][:password] == params[:user][:password_confirmation]
        flash.now[:alert] = 'Password confirmation does not match.'
        return render :edit, status: :unprocessable_entity
      end

      if @user.update(user_params)
        # Password change was successful, log out the user
        reset_session # Clear the session
        redirect_to login_path, notice: 'Your password has been changed. Please log in again with your new password.'
        return
      else
        # Handle the case where password update fails due to other validation issues
        render :edit, status: :unprocessable_entity
        return
      end
    end

    # Handle general updates (excluding password changes)
    if @user.update(user_params.except(:password, :password_confirmation))
      redirect_to new_report_path, notice: 'User updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    unless current_user == @user || current_user.admin?
      flash[:alert] = "Du bist nicht berechtigt, diese Aktion auszuführen."
      redirect_to(root_url)
    end
  end

  def user_params
    params.require(:user).permit(:firstName, :lastName, :email, :password, :password_confirmation)
  end
end

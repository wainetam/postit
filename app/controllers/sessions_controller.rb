class SessionsController < ApplicationController
  skip_before_action :require_login
  # , except: [:destroy] only:

  def new #login
    # @current_user.id = @user.id
    # @current_user = User.new(params[:session])
    @current_user = User.new
  end

  def create
    # debugger
    @current_user = User.find_by_username(params[:username])
    # @current_user.id = @user.id
    # debugger

    if @current_user && @current_user.authenticate(params[:password])
      session[:user_id] = @current_user.id
      # params[:session][:user_id] = @current_user.id  
      # session[:user_id] = @current_user.id  
      flash[:notice] = "You have successfully logged in"
      redirect_to root_path
    else
      flash.now[:notice] = "There is something wrong with your email/password"
      render :new
    end
  end

  def destroy #logout
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end
end

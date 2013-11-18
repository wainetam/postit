class UsersController < ApplicationController
  before_action :require_login, except: [:new, :show]

  def new
    @user = User.new
  end

  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    # @user = User.new
    # debugger

    if @user.save
      flash[:notice] = "Thank you for registering, #{@user.username}"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])  
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "You have updated your user details"
      redirect_to user_path
    else
      render :update
    end
  end

  # private

  def user_params
  #   # params.require(:post).permit(:title, :url)
    # params.require(:user).permit!
    # params.require(:creator).permit!
    params.require(:user).permit(:username, :password, :created_at, :updated_at)
  end

end
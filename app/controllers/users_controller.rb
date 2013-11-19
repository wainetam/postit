class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_login, except: [:new, :show]
  before_action :require_login_by_id, only: [:edit]

  def new
    @user = User.new
  end

  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    # @user = User.new

    if @user.save
      flash[:notice] = "Thank you for registering, #{@user.username}"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    # debugger
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "You have updated your user details"
      redirect_to user_path
    else
      render :update
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  #   # params.require(:post).permit(:title, :url)
    # params.require(:user).permit!
    # params.require(:creator).permit!
    params.require(:user).permit(:username, :password, :created_at, :updated_at)
  end

  def require_login_by_id
    unless logged_in_as_creator?(@user)
      flash[:error] = "You need to login as the user to complete that action"
      redirect_to login_path
    end
  end    

end
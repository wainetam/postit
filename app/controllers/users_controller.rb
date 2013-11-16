class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # @user = User.new(params[:creator])
    @user = User.new(params[user_params])
    # @user = User.new
    # debugger

    if @user.save
      flash[:notice] = "Thank you for registering, #{@user.username}"
      redirect_to root_path
    else
      render :new
    end
  end

  # private

  def user_params
  #   # params.require(:post).permit(:title, :url)
    # params.require(:user).permit!
    params.require(:user).permit(:username, :password)
  end

end
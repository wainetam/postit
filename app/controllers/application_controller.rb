class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper

  before_action :require_login

  private

  def require_login 
    unless logged_in?
      flash[:error] = "You must be logged in to complete that action"
      redirect_to login_path
    end
  end

  def one_vote_per_user(object)
    vote_array = object.votes
    vote_array.each do |vote_obj|
      if session[:user_id] == vote_obj.user_id  
        vote_obj.errors.add(:vote, "User can't vote more than once to same content")
        flash[:error] = "You already voted!"
        redirect_to :back and return
      end  
    end
  end

end

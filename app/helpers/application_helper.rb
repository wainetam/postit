module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end

  def display_time(time)
    time.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%y %l:%M%P %Z")
  end

  def logged_in?
    if session[:user_id]
      true
    else
      false
    end
  end

  def logged_in_as_post_creator?(obj)
    if session[:user_id] == obj.user_id
      true
    else
      false
    end
  end

  def current_username_by_id
    # if there's an authenticated user, will return username
    # else returns nil
    if session[:user_id]
      User.find_by_id(session[:user_id]).username
    else  
      nil
    end
  end
end

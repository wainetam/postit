module ApplicationHelper
  def fix_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end

  def display_time(time)
    time.in_time_zone("Eastern Time (US & Canada)").strftime("%m/%d/%y %l:%M%P %Z")
  end
end

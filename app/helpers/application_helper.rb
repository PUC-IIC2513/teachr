module ApplicationHelper
  
  def nav_link(text, url)
    content_tag(:li, link_to(text, url), class: current_page?(url) ? "selected" : "")
  end
  
end

module ResourcesHelper
  
  def tag_list(tags)
    tags.map {|t| link_to t.name, tag_path(t)}.join(', ').html_safe
  end
  
  
end

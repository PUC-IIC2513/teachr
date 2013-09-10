module ResourcesHelper
  
  def tag_list(tags)
    tags.map {|t| link_to t.name, tag_resources_path(t.id)}.join(', ').html_safe
  end
  
  
end

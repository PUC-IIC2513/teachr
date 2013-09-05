class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :resources_tags, dependent: :destroy
  has_many :tags, through: :resources_tags
  
  def tag_names
    tags.map {|t| t.name}.join(', ')
  end
  
  def process_tags(tag_names, user)
    user = User.find(user) unless user.is_a?(User)
    new_tag_names = tag_names.split(/ *, */) unless tag_names.is_a?(Array)
    existing_tag_names = tags.map {|t| t.name}
    tags_to_delete = existing_tag_names - new_tag_names
    tags_to_add = new_tag_names - existing_tag_names
    
    # eliminamos los tags
    resources_tags.destroy(resources_tags.select(:'resources_tags.id').joins(:tag).where(tags: {name: tags_to_delete})) if tags_to_delete.any?
    # agregamos los tags
    tags_to_add.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      resources_tags.build(tag: tag, user: user)
    end
  end
end

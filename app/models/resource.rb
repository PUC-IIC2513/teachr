class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :resources_tags, dependent: :destroy
  has_many :tags, through: :resources_tags
  
  def tag_names
    tags.map {|t| t.name}.join(', ')
  end
  
  def update_tags!(tag_names, user)
    user = User.find(user) unless user.is_a?(User)
    tag_changes = tags_to_modify(tag_names)
    puts tag_changes
    remove_tags! tag_changes[:to_delete]
    add_tags! tag_changes[:to_add]
    save!
  end
  
  private
  
  def add_tags!(tags_names)
    tags_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      resources_tags.build(tag: tag, user: user)
    end
  end
  
  def remove_tags!(tags_names)
    to_delete = to_resources_tags(tags_names)
    raise "Error deleting tags" if resources_tags.destroy(to_delete) != to_delete
  end
  
  def to_tags_array(tags_string)
    tags_string.is_a?(Array) ? tags_string : tags_string.split(/ *, */)
  end
  
  def tags_to_modify(tags_names)
    tags_names = to_tags_array(tags_names)
    existing_tag_names = tags.map {|t| t.name}
    { to_delete: existing_tag_names - tags_names, to_add: tags_names - existing_tag_names }
  end
  
  def to_resources_tags(tag_names)
    resources_tags.select(:'resources_tags.id').joins(:tag).where(tags: {name: tag_names})
  end
end

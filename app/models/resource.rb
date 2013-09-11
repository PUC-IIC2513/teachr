class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :resources_tags, dependent: :destroy
  has_many :tags, through: :resources_tags

  attr_accessor :temp_file

  after_validation :process_file_or_url

  validates :name, presence: true
  validates :user_id, presence: true
  validate do |resource|
    unless !resource.url.blank? || resource.temp_file.is_a?(ActionDispatch::Http::UploadedFile) || !resource.file.blank?
      resource.errors[:base] << "Must include a file or URL of the resource"
    end
  end
  
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
  
  def storage_location
    @storage_location ||= Rails.root.join('public')
  end

  def process_file_or_url
    if temp_file && temp_file.is_a?(ActionDispatch::Http::UploadedFile)
      web_path = File.join('uploads', "#{Digest::SHA1.hexdigest(Time.now.to_s)}_#{temp_file.original_filename}")
      path = File.join(storage_location, web_path)
      File.open(path, 'wb') do |file|
        file.write(temp_file.read)
      end
      self.file = web_path
      self.temp_file = nil
    elsif !self.url.blank? && self.file
      path = File.join(storage_location, 'upload', self.file)
      File.delete(path) if File.exists?(path)
      self.file = nil
    end
  end

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

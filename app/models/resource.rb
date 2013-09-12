class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :resources_tags, dependent: :destroy
  has_many :tags, through: :resources_tags

  attr_accessor :temp_file

  after_validation :process_file_or_url
  after_save :move_file

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

  def file_url
    "/uploads/#{self.id}/#{self.file}" unless self.file.blank?
  end
  
  private
  
  def storage_location
    @storage_location ||= Rails.root.join('public', 'uploads')
  end

  def web_location
    @web_location ||= 'uploads'
  end

  def process_file_or_url
    if temp_file && temp_file.is_a?(ActionDispatch::Http::UploadedFile)
      puts "ASDJASKDJASKDJASD"
      @filename = temp_file.original_filename
      @temp_file_path = File.join(storage_location, "#{Digest::SHA1.hexdigest(Time.now.to_s)}_#{@filename}")
      File.open(@temp_file_path, 'wb') do |file|
        file.write(temp_file.read)
      end
      self.file = @filename
      self.url = nil
      self.temp_file = nil
      puts "ARCHIVO: #{@filename}"
    elsif !self.url.blank? && self.file
      path = File.join(storage_location, 'upload', self.file)
      File.delete(path) if File.exists?(path)
      self.file = nil
    end
  end

  def move_file
    unless @temp_file_path.blank? || !File.exists?(@temp_file_path)
      path = File.join(storage_location, self.id.to_s)
      puts "SIIII Moviendo file... #{@temp_file_path} a #{path}"
      Dir.mkdir(path) unless File.directory?(path)
      new_path = File.join(path, @filename)
      File.rename(@temp_file_path, new_path)
    end
  rescue => e
    puts e.message
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

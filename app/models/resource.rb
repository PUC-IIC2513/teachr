class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :resources_tags
  has_many :tags, through: :resources_tags
  
  accepts_nested_attributes_for :resources_tags, allow_destroy: true, reject_if: proc { |attributes| attributes[:tag_id].blank? }
  
end

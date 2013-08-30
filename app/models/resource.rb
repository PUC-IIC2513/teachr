class Resource < ActiveRecord::Base
  belongs_to :user
  has_many :resources_tags
  has_many :tags, through: :resources_tags
end

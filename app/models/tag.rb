class Tag < ActiveRecord::Base
  has_many :resources_tags
  has_many :resources, through: :resources_tags
end

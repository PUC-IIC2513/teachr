class User < ActiveRecord::Base
  has_many :announcements, dependent: :destroy

end

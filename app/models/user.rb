class User < ActiveRecord::Base
  has_many :announcements, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, uniqueness: true
  validates :password, confirmation: true, presence: true, length: { in: 8..50 }
  validates :password_confirmation, presence: true
  validates :role, inclusion: { in: %w{student teacher assistant} }
  
end

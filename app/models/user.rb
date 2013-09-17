class User < ActiveRecord::Base
  has_many :announcements, dependent: :destroy
  
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, uniqueness: true
  validates :role, inclusion: { in: %w{student teacher assistant} }
  # Las validaciones de password son agregadas automáticamente por has_secure_password

  def self.authenticate(email, password)
  	User.find_by(email: email).try(:authenticate, password)
  end
  
end

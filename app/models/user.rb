class User < ActiveRecord::Base
  
  before_save :check_email_changes
  
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
  
  def check_email_changes
    if changed.include? "email"
      self.validated = false
      self.validation_hash = generate_hash
    end
  end
  
  def generate_hash
    Digest::SHA1.hexdigest "#{self.id}-#{self.email}-#{Time.now}"
  end
  
end

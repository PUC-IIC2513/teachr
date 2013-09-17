class ChangePasswordToPasswordDigestToUser < ActiveRecord::Migration
  def up
    # cambiamos el nombre de la columna por la convencion de has_secure_password
    rename_column :users, :password, :password_digest
    User.reset_column_information
    # transformamos las passwords a un hash de la forma en que lo hace BCrypt
    require 'bcrypt'
    User.all.each do |u|
      u.password_digest = BCrypt::Password.create(u.password_digest).to_s
      u.save
    end
  end
end

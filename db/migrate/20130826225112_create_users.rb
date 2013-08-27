class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false, limit: 100
      t.string :last_name, null: false, limit: 100
      t.string :email, null: false, limit: 200
      t.string :password, null: false, limit: 50
      t.string :role, default: 'student'

      t.timestamps
    end
  end
end

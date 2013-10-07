class AddValidatedAndValidationHashToUser < ActiveRecord::Migration
  def change
    add_column :users, :validated, :boolean
    add_column :users, :validation_hash, :string
  end
end

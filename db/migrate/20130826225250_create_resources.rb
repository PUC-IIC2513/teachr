class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, null: false
      t.text :description
      t.string :file
      t.string :url
      t.references :user, index: true

      t.timestamps
    end
  end
end

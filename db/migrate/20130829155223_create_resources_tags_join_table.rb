class CreateResourcesTagsJoinTable < ActiveRecord::Migration
  def change
    create_table :resources_tags, id: false do |t|
      t.references :resource
      t.references :tag
    end
    
    add_index :resources_tags, [:resource_id, :tag_id], unique: true
  end
end

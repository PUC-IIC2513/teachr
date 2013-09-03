class AddIdToResourcesTag < ActiveRecord::Migration
  def change
    add_column :resources_tags, :id, :primary_key
  end
end

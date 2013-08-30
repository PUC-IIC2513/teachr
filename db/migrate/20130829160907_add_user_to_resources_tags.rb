class AddUserToResourcesTags < ActiveRecord::Migration
  def change
    add_reference :resources_tags, :user, index: true
  end
end

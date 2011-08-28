class AddUserIdToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.integer :user_id
    end    
    add_index "comments", "user_id"
  end

  def self.down
    remove_column :comments, :user_id
  end
end

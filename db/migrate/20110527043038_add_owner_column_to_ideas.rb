class AddOwnerColumnToIdeas < ActiveRecord::Migration
  def self.up
    change_table :ideas do |t|
      t.integer :user_id
    end  
    add_index "ideas", "user_id"
  end

  def self.down
    remove_column :comments, :user_id
  end  
end

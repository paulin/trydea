class AddTypeToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.text :comment_type, :default =>""
    end    
  end

  def self.down
    remove_column :comments, :comment_type
  end
end

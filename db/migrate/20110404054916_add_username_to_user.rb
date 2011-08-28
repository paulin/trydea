class AddUsernameToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.text :username, :default =>""
    end  
  end

  def self.down
    remove_column :users, :username
  end
end

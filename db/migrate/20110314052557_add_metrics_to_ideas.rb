class AddMetricsToIdeas < ActiveRecord::Migration
  def self.up
    change_table :ideas do |t|
      t.float :score, :default => 0
      t.integer :compare_count, :default => 0
    end    
  end
  
  def self.down
    remove_column :ideas, :score
    remove_column :ideas, :compare_count
  end
end

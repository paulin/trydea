class AddTeamCountToIdeas < ActiveRecord::Migration
  def self.up  
    add_column :ideas, :teams_count, :integer, :default => 0  
      
    Idea.reset_column_information  
    Idea.all.each do |p|  
      p.update_attribute :teams_count, p.users.length  
    end  
  end  
  
  def self.down  
    remove_column :ideas, :teams_count  
  end  
end

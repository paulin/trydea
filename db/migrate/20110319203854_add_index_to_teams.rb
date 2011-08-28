class AddIndexToTeams < ActiveRecord::Migration
  def self.up
    add_index :teams, :user_id
    add_index :teams, :idea_id
    add_index :teams, :team_id
  end
  def self.down
    remove_index :teams, :user_id
    remove_index :teams, :idea_id
    remove_index :teams, :team_id
  end
end

class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.integer :user_id
      t.integer :idea_id
      t.integer :team_id

      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end

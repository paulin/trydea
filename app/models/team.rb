# == Schema Information
# Schema version: 20110408140910
#
# Table name: teams
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  idea_id    :integer
#  team_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea, :counter_cache => true #http://asciicasts.com/episodes/23-counter-cache-column
end

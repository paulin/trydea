# == Schema Information
# Schema version: 20110408140910
#
# Table name: ideas
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#  score         :float           default(0.0)
#  compare_count :integer         default(0)
#  teams_count   :integer         default(0)
#

class Idea < ActiveRecord::Base
  
  attr_accessible :name, :score, :compare_count, :description, :teams_count
  validates :name,  :presence => true
  validates :description, :presence => true,
                    :length => { :minimum => 10 }
  has_many :comments, :dependent => :destroy
  has_many :teams
  has_many :users, :through => :teams
  

  def remove_team_member(user_to_remove)
    #I did this because the team counter wasn't being decremented
    #http://blog.gridworlds.com/rails/delete-or-delete-removing-things-in-rails
    #http://osdir.com/ml/lang.ruby.rails.core/2008-12/msg00054.html

#    users.delete(user_to_remove) #Old way    
#    printf("\n Team Count = [%s]\n", teams.length)

    #Need to get the team that the user is on
    #Then destroy the team
    #    user_to_remove.destroy
    
    #Eventually found this http://railsforum.com/viewtopic.php?id=23048
    for user_to_remove in users
      Team.find_by_user_id_and_idea_id(user_to_remove.id, self.id).destroy
    end

  end
    
  def calc_score
    if compare_count == 0 
      return 0

    else 
      ((score/compare_count + 1) * 50).round
    end
  end
end

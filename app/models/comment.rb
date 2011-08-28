# == Schema Information
# Schema version: 20110408140910
#
# Table name: comments
#
#  id           :integer         not null, primary key
#  commenter    :string(255)
#  comment      :text
#  idea_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  comment_type :text            default("")
#  user_id      :integer
#

class Comment < ActiveRecord::Base
  attr_accessible :comment, :commenter, :comment_type
  belongs_to :idea
  belongs_to :user
end

class TeamController < ApplicationController
  def index
  end

  def join_team
    ideaid = params['ideaid']
    userid = params['userid']
    
    #update the values
    idea = Idea.find(ideaid)
    user = User.find(userid)
    
    printf("\n Joining Team [UserId %s, IdeaId %s]\n", userid, ideaid)

    idea.users << user
    
    render :text => "success"
    #given the id of the user and the id of the idea, add the user to this team
  end

  def leave_team
    
    #given the id of the user and the id of the idea, remove the user from the team
    ideaid = params['ideaid']    
    userid = params['userid']
    
    printf("\n Leaving Team [UserId %s, IdeaId %s]\n", userid, ideaid)
    
    #update the values
    idea = Idea.find(ideaid)
    user = User.find(userid)
         
    idea.remove_team_member(user)     
        
    render :text => "success"
  end

end

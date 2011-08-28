class IdeaComparatorController < ApplicationController
  before_filter :authenticate_user!

  # GET /ideas
  # GET /ideas.xml
  def index
    
    ideaNum = rand(Idea.count -1) + 1
    ideaNum2 = rand(Idea.count -1) + 1
    while ideaNum == ideaNum2 do
      ideaNum2 = rand(Idea.count -1) + 1
    end
    
    printf("\n Idea Indexes =%s and %s",ideaNum, ideaNum2)
    @idea1 = Idea.find(ideaNum)    
    @idea2 = Idea.find(ideaNum2)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ideas }
    end
  end  
  
  def update_values
    winner = params['winner']
    loser = params['loser']
    
    #update the values
    winnerIdea = Idea.find(winner)
    loserIdea = Idea.find(loser)
    
    #alter the score
    winnerIdea.score = winnerIdea.score + 1;
    loserIdea.score = loserIdea.score - 1;
        
    #increment the counts
    winnerIdea.compare_count = winnerIdea.compare_count + 1
    loserIdea.compare_count = loserIdea.compare_count + 1    
    
    #save
    winnerIdea.save
    loserIdea.save

    printf("\n update values called winner [%s, count %s, score %s] loser [%s, count %s, score %s]\n", winner, winnerIdea.compare_count, winnerIdea.score, loser, loserIdea.compare_count, loserIdea.score)

    #now get some new ideas
    ideaNum = rand(Idea.count -1) + 1
    ideaNum2 = rand(Idea.count -1) + 1
    while ideaNum == ideaNum2 do
      ideaNum2 = rand(Idea.count -1) + 1
    end
    
    printf("\n Idea Indexes =%s and %s",ideaNum, ideaNum2)
    @idea1 = Idea.find(ideaNum)    
    @idea2 = Idea.find(ideaNum2)

    
    #var response = {idea1: {id:n,name:'name',description:'desc'},idea2: {id:n,name:'name',description:'desc'}} 
    #render :action => "result.json"
    render :text => Hash["idea1", @idea1, 
                         "idea2", @idea2, 
                         "idea1join", @idea1.users.exists?(current_user), 
                         "idea2join", @idea2.users.exists?(current_user)].to_json
    
#    render :action => "result"
    
#    respond_to do |format|
      #render :action => "result"
      #render :template => "idea_comparator/result"
#    end
  end
  
  # GET /ideas/1
  # GET /ideas/1.xml

  def show
    
#    @idea = Idea.find(params[:id])

#    respond_to do |format|
#      format.html # show.html.erb
#    end
  end  
end

class MobileGatewayAuthorizedController < ApplicationController
  before_filter :basic_auth
  
  def get_user_info
    puts @current_user.to_json    
    logger.info("get_user_info, session info" + session.inspect)
    
    userdata = Hash["username",@current_user.username, "email", @current_user.email, "userid", @current_user.id.to_s]
    render :text => Hash["status", "success", "user", userdata].to_json
  end

  def list_idea_statuses
    puts "list_idea_statuses called"
    
    #{"status":"success",
    # "statuses":[
    #    {"ideaid":"1","name":"Idea 1","description":"idea 1 description","fight_count":"3","score":"2","comment_count":"5","team_size_count":"2"},
    #    {"ideaid":"2","name":"idea 2","description":"idea 2 description","fight_count":"10","score":"1","comment_count":"2","team_size_count":"5"}
    #]}

    ideas = current_user.ideas
    statusdata = []    
    ideas.each{ |i| statusdata.push(Hash["ideaid", i._id.to_s, "name", i.name, "description", i.description, "fight_count", i.compare_count.to_s, "score", i.score.round.to_s, "comment_count", i.comments.length.to_s,"team_size_count", i.teams_count.to_s])}      
    render :text => Hash["status", "success", "statuses", statusdata].to_json        
  end

  def add_comment
    puts "add_comment called"
    
    idea = Idea.find(params[:ideaid])  
    
    #condition the comment type
    comment_type = params[:type].downcase
    if comment_type == "name"
      comment_type = "Naming Suggestion"
    elsif comment_type == "feature"
      comment_type = "Feature Suggestion"
    elsif comment_type == "competitor"
      comment_type = "Competitor"
    else 
      comment_type = "Comment"
    end
      
    puts comment_type
    
    #build the comment here
    comment = Comment.new
    comment.comment = params[:comment]
    comment.comment_type = comment_type
    @current_user.comments << comment
    
    #pulling the username out seperately.  This may be stupid but, I like the idea that it might be faster 
    # when showing comments.  Feel free to flame me for bad design -Matt
    comment.commenter = @current_user.username
    comment.save
    idea.comments << comment    
        
    render :text => ideaToJsonResponse(idea)          
  end

  def ideaToJsonResponse( idea ) 
    teamdata = []
    idea.users.each { |i| teamdata.push(Hash["name", i.username])}

    commentdata = []
    idea.comments.each { |i| commentdata.push(Hash["comment", i.comment, "author", i.commenter, "type", fixCommentType(i.comment_type)])}

    ideadata = Hash["ideaid",idea._id.to_s, "name", idea.name, "description", idea.description, "fight_count", idea.compare_count, "score", idea.score, "team_members", teamdata, "comments", commentdata]
    return Hash["status", "success", "idea", ideadata].to_json
  end

  def fixCommentType( ctype )
    
    comment_type = "comment"
    if ctype == "Naming Suggestion"
      comment_type = "name"
    elsif ctype == "Feature Suggestion"
      comment_type = "feature"
    elsif ctype == "Competitor"
      comment_type = "competitor"
    end
    return comment_type
  end
  
  def join_team
    puts "join_team called"
    
    idea = Idea.find(params[:ideaid])  
    idea.users << @current_user
        
    render :text => ideaToJsonResponse(idea)          
  end  
  
  def leave_team
    puts "leave_team called"
    
    idea = Idea.find(params[:ideaid])  
    idea.remove_team_member(@current_user)    
    
    render :text => ideaToJsonResponse(idea)          
  end

  def get_idea
    puts "get_idea called"
    #{"status":"success",
    #  "idea": {"ideaid":"1","name":"Idea 1","description":"idea 1 description","fight_count":"3","score":"2",
    #     "team_members":[
    #         {"name":"bob"},
    #         {"name":"jim"}],
    #     "comments":[
    #         {"comment":"wow what an idea","author":"jim","type":"comment"},
    #         {"comment":"did you see these blip.com?","author":"larry","type":"compeditor"},
    #         {"comment":"Can if fly me to work?","author":"dan","type":"feature_suggestion"},
    #         {"comment":"wow what an idea","author":"james","type":"name_suggestion"}]
    #}}
    
    idea = Idea.find(params[:ideaid])    
    render :text => ideaToJsonResponse(idea)          
  end
      
  def submit_idea
    logger.info("submit_idea, session info" + session.inspect)
    name = params['name']
    description = params['description']
    
    idea = Idea.new(:name => name, :description => description)
    idea.user_id = @current_user.id #Should you automatically be signed up for ideas you create? 
    idea.users << @current_user
    
    respond_to do |format|
      if idea.save
        format.any(:xml, :json) {     
          ideadata = Hash["ideaid", idea.id.to_s]
          render :text => ideaToJsonResponse(idea)     
        }        
      else
        format.any(:xml, :json) {     
          format.html { render :action => "new" }
          render :text => Hash["status", "failure", "message", :unprocessable_entity ].to_json
        }
      end
    end
  end
  
  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|     
      user = User.find_by_username(username)
      if user 
        user.valid_password?(password)
        session[:current_user_id] = user.id
        @current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
      else
        false
      end
    end 
    warden.custom_failure! if performed? 
  end
  
  # Finds the User with the ID stored in the session with the key :current_user_id
  # This is a common way to do user login in a Rails application; logging in sets the
  # session value and logging out removes it
  def current_user
    @_current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end  
end

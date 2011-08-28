class CommentsController < ApplicationController
  before_filter :authenticate_user! 
  def index
    @comments = Comment.all
    respond_to do |format|
      format.html # index.html.erb
      format.rss
    end
  end
  
  def create
    #Note, I don't know if this is the right way to do this, but its the only way I could pull the parameters out
    #Thoughts? -Matt
    @user = User.find(params['comment']['user_id'])
    @idea = Idea.find(params['idea_id'])
    
    #build the comment here
    @comment = Comment.new
    @comment.comment = params['comment']['comment']
    @comment.comment_type = params['comment_type']
    @user.comments << @comment
    
    #pulling the username out separately.  This may be stupid but, I like the idea that it might be faster 
    # when showing comments.  Feel free to flame me for bad design -Matt
    @comment.commenter = @user.username
    @comment.save
    @idea.comments << @comment
    redirect_to idea_path(@idea)
  end
  
  def destroy
    @idea = Idea.find(params[:idea_id])
    @comment = @idea.comments.find(params[:id])
    @comment.destroy
    redirect_to idea_path(@idea)
  end
end

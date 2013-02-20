 class IdeasController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /ideas
  # GET /ideas.xml
  def index
    @search = params[:search]
    if @search == nil 
      @search = "name"
    end
    
    puts "Session search: #{session[@search]}"
    if(session[@search].nil? || session[@search] == "DESC")
      session[@search] = "ASC"
      puts "Set to ASC"
    else
      session[@search] = "DESC"
      puts "Set to DESC"
    end
    
    if @search == "name"
      @ideas = Idea.order(@search + " #{session[@search]}").page(params[:page]).per(20)  
    else 
      @ideas = Idea.order(@search + " #{session[@search]}").page(params[:page]).per(20)  
    end
    
    puts "Searching!!! Searching!!! Searrrrrching!"
    puts "Ideas num: #{@ideas.count}"
    
    if(!@ideas.nil?)
            @ideas.each do |i|
              puts "Created at #{i.created_at}"
            end
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ideas }
    end
  end

  # GET /ideas/1
  # GET /ideas/1.xml
  def show
    @idea = Idea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @idea }
    end
  end

  # GET /ideas/new
  # GET /ideas/new.xml
  def new
    @idea = Idea.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @idea }
    end
  end

  # GET /ideas/1/edit
  def edit
    @idea = Idea.find(params[:id])
  end

  # POST /ideas
  # POST /ideas.xml
  def create
    @idea = Idea.new(params[:idea])
    @idea.user_id = current_user.id #Should you automatically be signed up for ideas you create? 
    @idea.users << current_user
    
    respond_to do |format|
      if @idea.save
        format.html { redirect_to(@idea, :notice => 'Idea was successfully created.') }
        format.xml  { render :xml => @idea, :status => :created, :location => @idea }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ideas/1
  # PUT /ideas/1.xml
  def update
    @idea = Idea.find(params[:id])

    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        format.html { redirect_to(@idea, :notice => 'Idea was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @idea.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.xml
  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to(ideas_url) }
      format.xml  { head :ok }
    end
  end
end

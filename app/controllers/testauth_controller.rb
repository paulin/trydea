class TestauthController < ApplicationController
  before_filter :my_http_auth
  #before_filter :authenticate_user! #Cause it to redirect back  
  
  def login
    @login = params['username']
    @password = params['password']
    
    #    user = User.create!( 
    #           :email => 'test@test.com', 
    #           :password => 'test', 
    #           :password_confirmation => 'test' 
    #         ) 
    #    sign_in user 
    #    user.confirm! 
    #    user 
    
    
    #logger.info("logged in")
    #sign_in(@login, @password)   
    
    #respond_to do |format|
    #  if user
    #    format.html do 
    #      reset_session
    #      session[:user_id] = user.id
    #      redirect_back_or_default root_url 
    #    end
    #    format.any(:xml, :json) { head :ok }
    #  else
    #    format.html do 
    #      flash.now[:error] = "Invalid login or password."
    #      render :action => :new 
    #    end
    #    format.any(:xml, :json) { request_http_basic_authentication }
    #  end
    #end    
  end

  def destroy
    reset_session
    session[:user_id] = nil
    redirect_to login_url #Brasten did this with the :as => magic
  end

  private
  #How does the user_name and password even get to here?
  def my_http_auth 
    authenticate_or_request_with_http_basic do |username, password| 
      puts username
      puts password
      user = User.find_by_username(username)
      if user
        puts "Password = " + user.encrypted_password
#        user.valid_password?(password)
      else
        false
      end
      #      user_name == "foo" && password == "bar" 
    end 
    warden.custom_failure! if performed? 
  end 
  
end

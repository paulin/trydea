class MobileGatewayOpenController < ApplicationController
  def register
    logger.info("register, session info" + session.inspect)
    
    username = params['username']
    password = params['password']
    email = params['email']  
    puts username   
    puts password   
    puts email   
    
    @current_user = User.create(:username => username, :email => email, :password => password, :password_confirmation => password, :first_name => '', :last_name => '')
    
    puts @current_user
    
    respond_to do |format|
      format.html do 
        flash.now[:error] = "No support for html."
        render :action => :new 
      end
      format.any(:xml, :json) {     
        userdata = Hash["username",@current_user.username, "email", @current_user.email, "userid", @current_user.id.to_s]
        render :text => Hash["status", "success", "user", userdata].to_json        
      }
    end

  end

  def forgot_password
    logger.info("forgot_password, session info" + session.inspect)
    respond_to do |format|
      format.html do 
        flash.now[:error] = "No support for html."
        render :action => :new 
      end
      format.any(:xml, :json) {     
        render :text => Hash["status", "success"].to_json
      }
    end
  end
end

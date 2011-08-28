class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    code = params['signup_code']
    if code == 'pugetworks'
      #Let them in
      super
    else
      flash[:error] = "Sorry, we are still building this out.  It will be up soon, please try again later"      
    end    
  end

  def update
    super
  end
end 
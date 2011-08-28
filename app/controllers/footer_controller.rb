class FooterController < ApplicationController
  
  def index
  end

  def about
  end
  def new 
    @contact_form = ContactForm.new
  end
  
  def send_email
    @contact_form = ContactForm.new(params[:contact_form])
    if !@contact_form.valid?
      Notifications.contact(@contact_form).deliver
      redirect_to root_path, :notice => "Email sent."
    else
      render 'new'
    end
  end
end

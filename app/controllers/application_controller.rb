class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  
  # Devise: Where to redirect users once they have logged in
  def after_sign_in_path_for(resource)
    "/idea_comparator" # <- Path you want to redirect the user to.
  end
end

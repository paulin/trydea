IdeaEngine::Application.routes.draw do

  devise_for :users, :path_names => { :sign_up => "register" }, :controllers => {:registrations => "registrations"}

  resources :users 
  
  get "mobile_gateway_authorized/get_idea"
  get "mobile_gateway_authorized/list_idea_statuses"
  get "mobile_gateway_authorized/get_user_info"
  post "mobile_gateway_authorized/leave_team"
  post "mobile_gateway_authorized/join_team"
  post "mobile_gateway_authorized/add_comment"
  post "mobile_gateway_authorized/submit_idea"

  post "mobile_gateway_open/register"
  post "mobile_gateway_open/forgot_password"

  get "testauth/login", :as => "login"
  get "testauth/annihilate" => "testauth#destroy"

  get "team/index"

  get 'idea_comparator/update_values'
  resources :idea_comparator

  get 'team/join_team'
  get 'team/leave_team'
  resources :team

  resources :ideas do
    resources :comments
  end
  
  match "about" => "footer#about"
  match "credits" => "footer#credits"
  root :to => "home#index"
  
end

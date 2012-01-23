Authorzen::Application.routes.draw do
  resource :profile, :only => [:edit, :update] do
    member do
      get :setup
    end
  end
  
  mount Forem::Engine, :at => "/forums"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/:provider/callback" => "sessions#create"

  get "/dashboard" => 'dashboard#index', :as => :dashboard

  root :to => "dashboard#index"
end

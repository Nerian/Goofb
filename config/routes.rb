Goofb::Application.routes.draw do
  
  post "export/create"
  get "export/new"
  
  get "session/create"
  get "session/new"
  
  get "home/index"
  get "home/show"
  
  root :to => "home#index"
end

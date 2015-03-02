Houston::Itsm::Engine.routes.draw do
  
  get "issues", :to => "issues#index"
  post "issues", :to => "issues#create"
  
end

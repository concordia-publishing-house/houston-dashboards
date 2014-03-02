Houston::Itsm::Engine.routes.draw do
  
  get "issues", :to => "issues#index"
  
end

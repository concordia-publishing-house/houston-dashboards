Houston::Dashboards::Engine.routes.draw do
  
  get "issues", :to => "issues#index"
  
end

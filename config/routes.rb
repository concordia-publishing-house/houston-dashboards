Houston::Dashboards::Engine.routes.draw do
  
  get "issues", :to => "issues#index"
  get "changes", :to => "releases#index"
  get "recent", :to => "releases#recent"
  get "upcoming", :to => "releases#upcoming"
  
end

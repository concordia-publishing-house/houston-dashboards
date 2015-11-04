Houston::Dashboards::Engine.routes.draw do

  scope "dashboards" do
    get "issues", :to => "issues#index"
    get "releases", :to => "releases#index"
    get "recent", :to => "releases#recent"
    get "upcoming", :to => "releases#upcoming"
    get "staging", :to => "staging#index"
  end

end

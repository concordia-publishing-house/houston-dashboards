class Houston::Itsm::IssuesController < ApplicationController
  layout "dashboard"
  
  def index
    benchmark("\e[33mFetch ITSMs\e[0m") do
      @issues = Houston::Itsm::Issue.all
    end
    
    benchmark("\e[33mLoad Users\e[0m") do
      users_by_email = User.all.each_with_object({}) { |user, map|
        user.email_addresses.each { |email| map[email.downcase] = user } }
      
      @issues.each do |issue|
        issue.assigned_to_user = users_by_email[issue.assigned_to_email]
      end
    end
    
    render partial: "houston/itsm/issues/fires" if request.xhr?
  end
  
end

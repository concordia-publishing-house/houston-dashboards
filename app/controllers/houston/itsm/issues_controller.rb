class Houston::Itsm::IssuesController < ApplicationController
  attr_reader :issues
  
  layout "dashboard"
  before_filter :find_issues
  
  def index
    benchmark("\e[33mLoad Users\e[0m") do
      users_by_email = User.all.each_with_object({}) { |user, map|
        user.email_addresses.each { |email| map[email.downcase] = user } }
      
      issues.each do |issue|
        issue.assigned_to_user = users_by_email[issue.assigned_to_email]
      end
    end
    
    render partial: "houston/itsm/issues/fires" if request.xhr?
  end
  
private
  
  def find_issues
    benchmark("\e[33mFetch ITSMs\e[0m") do
      begin
        @network_error = false
        @issues = Houston::Itsm::Issue.open
      rescue SocketError, Errno::ECONNREFUSED, Errno::ETIMEDOUT
        @network_error = true
        @issues = []
      end
    end
  end
  
end

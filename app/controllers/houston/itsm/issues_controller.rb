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
  
  def create
    issue_url = Houston::Itsm::Issue.create(
      username: current_user.username,
      summary: params[:summary],
      notes: params[:text])
    render json: {url: issue_url}
  end
  
private
  
  def find_issues
    benchmark("\e[33mFetch ITSMs\e[0m") do
      begin
        @network_error = false
        @issues = Houston::Itsm::Issue.open
      rescue SocketError, Errno::ECONNREFUSED, Errno::ETIMEDOUT, Net::ReadTimeout, Errno::EHOSTUNREACH
        @network_error = true
        @issues = []
      end
    end
  end
  
end

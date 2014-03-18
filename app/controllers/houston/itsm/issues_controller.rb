require 'ntlm/http'

class Houston::Itsm::IssuesController < ApplicationController
  
  def index
    users_by_email = benchmark("\e[33mEager-load users\e[0m") do
      User.all.each_with_object({}) { |user, map| user.email_addresses.each { |email| map[email.downcase] = user } }
    end
    
    ActiveRecord::Base.clear_active_connections! unless env.key?('rack.test')
    
    benchmark("\e[33mFetch ITSMs\e[0m") do
      http = Net::HTTP.start("ecphhelper", 80)
      req = Net::HTTP::Get.new("/ITSM.asmx/GetOpenCallsEmergingProducts")
      req.ntlm_auth("Houston", "cph.pri", "gKfub6mFy9BHDs6")
      response = http.request(req)
      issues = Hash.from_xml(response.body).fetch("ArrayOfOpenCallData").fetch("OpenCallData", [])
      @issues = Array.wrap(issues).map do |issue|
        url = Nokogiri::HTML::fragment(issue["CallDetailLink"]).children.first[:href]
        user = users_by_email[issue["AssignedToEmailAddress"].try(:downcase)]
        Issue.new(issue["Summary"], url, issue["AssignedToEmailAddress"], user)
      end
    end
    
    render partial: "houston/itsm/issues/fires" if request.xhr?
  end
  
  
  Issue = Struct.new(:summary, :url, :assigned_to_email, :assigned_to_user)
  
end

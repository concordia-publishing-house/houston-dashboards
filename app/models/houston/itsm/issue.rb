require "ntlm/http"

module Houston
  module Itsm
    class Issue < Struct.new(:summary, :url, :assigned_to_email, :assigned_to_user)
      
      
      def self.open
        http = Net::HTTP.start("ecphhelper", 80)
        req = Net::HTTP::Get.new("/ITSM.asmx/GetOpenCallsEmergingProducts")
        req.ntlm_auth("Houston", "cph.pri", "gKfub6mFy9BHDs6")
        response = http.request(req)
        parse_issues(response.body).map do |issue|
          url = Nokogiri::HTML::fragment(issue["CallDetailLink"]).children.first[:href]
          self.new(issue["Summary"], url, issue["AssignedToEmailAddress"].try(:downcase))
        end
      end
      
      
    private
      
      def self.parse_issues(xml)
        Array.wrap(
          Hash.from_xml(xml)
            .fetch("ArrayOfOpenCallData", {})
            .fetch("OpenCallData", []))
      rescue REXML::ParseException # malformed response upstream
        Rails.logger.error "\e[31;1m#{$!.class}\e[0;31m: #{$!.message}"
        []
      end
      
    end
  end
end

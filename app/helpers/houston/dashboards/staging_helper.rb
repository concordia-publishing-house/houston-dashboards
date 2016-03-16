module Houston::Dashboards
  module StagingHelper

    def checkboxes(pull_request)
      checked = completed_checkboxes(pull_request)
      total = total_checkboxes(pull_request)
      "<span class='label'>#{checked}/#{total}</span>".html_safe unless total < 1
    end

    def completed_checkboxes(pull_request)
      pull_request.body.to_s.scan("[x]").count
    end

    def total_checkboxes(pull_request)
      completed = pull_request.body.to_s.scan("[x]").count
      not_completed = pull_request.body.to_s.scan("[ ]").count
      completed + not_completed
    end

    def staging_status(pull_request)
      labels = pull_request.labels.select { |name| ['test-pass', 'test-hold'].include?(name)}
      label_out = ""
      labels.each do |label|
        label_out << "<span class=\"pr-tag #{label}\">&nbsp;</span>"
      end
      label_out.html_safe
    end

  end
end

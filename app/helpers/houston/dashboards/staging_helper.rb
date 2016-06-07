module Houston::Dashboards
  module StagingHelper

    def checkboxes(pull_request)
      checked = completed_checkboxes(pull_request)
      unchecked = unchecked_checkboxes(pull_request)
      """
      #{unchecked} <i class='fa fa-square-o' aria-hidden='true'></i>
      #{checked} <i class='fa fa-check-square-o' aria-hidden='true'></i>
      """.html_safe if checked || unchecked
    end

    def completed_checkboxes(pull_request)
      pull_request.body.to_s.scan("[x]").count
    end

    def unchecked_checkboxes(pull_request)
      pull_request.body.to_s.scan("[ ]").count
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

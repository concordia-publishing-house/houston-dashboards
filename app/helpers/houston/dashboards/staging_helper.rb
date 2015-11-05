module Houston::Dashboards
  module StagingHelper

    def checkboxes(pull_request)
      checked = completed_checkboxes(pull_request)
      total = total_checkboxes(pull_request)
      "<span class='label'>#{checked}/#{total}</span>" unless total < 1
    end

    def completed_checkboxes(pull_request)
      pull_request.body.scan("[x]").count
    end

    def total_checkboxes(pull_request)
      completed = pull_request.body.scan("[x]").count
      not_completed = pull_request.body.scan("[ ]").count
      completed + not_completed
    end
  end
end

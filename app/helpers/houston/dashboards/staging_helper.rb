module Houston::Dashboards
  module StagingHelper
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

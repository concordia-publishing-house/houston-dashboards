class Houston::Dashboards::PullsController < ApplicationController
  layout "houston/dashboards/dashboard"

  def index
    @queues = { wip: [], review_needed: [], test_pending: [], test_needed: [], deploy_needed: [] }
    pulls = Github::PullRequest.without_labels("archived", "experimental").order(created_at: :asc)
    pulls.each do |pull|
      if pull.labeled?("wip")
        @queues[:wip].push pull
        next
      end

      unless pull.labeled_any?("review-pass", "review-hold")
        @queues[:review_needed].push pull
      end

      if pull.labeled?("review-pass") && pull.labeled_any?("test-pass", "no-test")
        @queues[:deploy_needed].push pull
      elsif pull.labeled?("test-needed", "on-staging")
        @queues[:test_needed].push pull
      elsif pull.labeled?("test-needed") && !pull.labeled?("on-staging")
        @queues[:test_pending].push pull
      else
        @queues[:wip].push pull
      end
    end

    render partial: "houston/dashboards/pulls/pulls" if request.xhr?
  end

end

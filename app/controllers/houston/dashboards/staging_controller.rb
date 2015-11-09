class Houston::Dashboards::StagingController < ApplicationController
  layout "houston/dashboards/dashboard"

  def index
    @on_staging = Github::PullRequest.labeled "on-staging"
    @up_next = Github::PullRequest.labeled("test-needed").reject do |pr|
      pr.labels.include? "on-staging" || "wip"
    end

    @title = "Staging"
    @title << " (#{@on_staging.count})" if @on_staging.count > 0

    render partial: "houston/dashboards/staging/staging" if request.xhr?
  end

end

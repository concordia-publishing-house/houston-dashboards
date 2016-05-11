class Houston::Dashboards::StagingController < ApplicationController
  layout "houston/dashboards/dashboard"

  def index
    @on_staging = Github::PullRequest.open.labeled "on-staging"
    @up_next = Github::PullRequest.open.labeled("test-needed").without_labels("on-staging", "wip", "experimental")

    @title = "Staging"
    @title << " (#{@on_staging.count})" if @on_staging.count > 0

    render partial: "houston/dashboards/staging/staging" if request.xhr?
  end

end

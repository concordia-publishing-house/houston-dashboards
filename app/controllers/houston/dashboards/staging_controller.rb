class Houston::Dashboards::StagingController < ApplicationController
  layout "houston/dashboards/dashboard"

  def index
    @on_staging = Houston.github.org_issues(Houston.config.github[:organization], filter: "all", labels: "on-staging")
    @up_next = Houston.github.org_issues(Houston.config.github[:organization], filter: "all", labels: "test-needed")

    @title = "Staging"
    @title << " (#{@on_staging.count})" if @on_staging.count > 0

    render partial: "houston/dashboards/staging/staging" if request.xhr?
  end

end

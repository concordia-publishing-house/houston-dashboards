class Houston::Dashboards::StagingController < ApplicationController
  layout "houston/dashboards/dashboard"
  STAGING_PROJECTS = %w(members unite ledger bsb members-dav)
  def index
    @on_staging = currently_on_staging
    @up_next = up_next

    @title = "Staging"

    render partial: "houston/dashboards/staging/staging" if request.xhr?
  end

private

  def currently_on_staging
    on_staging = Hash.new
    STAGING_PROJECTS.each do |slug|
      project = Project.find_by_slug slug
      pull_request = on_staging_pull_requests(project)
      on_staging[slug] = {pull_request: pull_request, project: project} unless pull_request.nil?
    end
    on_staging
  end

  def up_next
    up_next = Hash.new
    STAGING_PROJECTS.each do |slug|
      project = Project.find_by_slug slug
      pull_requests = test_needed_pull_requests(project)
      up_next[slug] = {pull_requests: pull_requests, project: project} unless pull_requests.empty?
    end
    up_next
  end

  def on_staging_pull_requests(project)
    Houston.github.list_issues(
      "#{github_org}/#{project.slug}",
      labels: "on-staging",
      filter: "all")
        .select(&:pull_request).first
  end

  def test_needed_pull_requests(project)
    Houston.github.list_issues(
      "#{github_org}/#{project.slug}",
      labels: "test-needed",
      filter: "all")
        .select(&:pull_request)
  end

  def github_org
    Houston.config.github[:organization]
  end
end

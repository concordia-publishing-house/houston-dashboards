class Houston::Dashboards::ReleasesController < ApplicationController
  layout "houston/dashboards/dashboard"
  
  def index
    @title = "Changes"
    
    @upcoming_changes = %w{members unite ledger}.flat_map do |slug|
      project = Project.find_by_slug slug
      master = project.repo.branch "master"
      beta = project.repo.branch "beta"
      if master && beta
        release = Release.new(project: project)
        project.commits.between(master, beta)
          .map { |commit| ReleaseChange.from_commit(release, commit) }
          .reject { |change| change.tag.nil? }
      else
        []
      end
    end
    
    projects = Project.where(slug: %w{members unite ledger})
    releases = Release.where(project_id: projects.map(&:id)).limit(20)
    @recent_changes = releases.flat_map(&:release_changes).take(12)
  end
  
  def upcoming
    @title ="Upcoming"
    
    @changes = %w{members unite ledger}.flat_map do |slug|
      project = Project.find_by_slug slug
      branches = project.repo.branches
      master, beta = branches.values_at "master", "beta"
      commits = project.commits.between(master, beta)
      release = Release.new(project: project)
      commits.map { |commit| ReleaseChange.from_commit(release, commit) }
        .reject { |change| change.tag.nil? }
    end
    
    render partial: "houston/dashboards/issues/changes" if request.xhr?
  end
  
  def recent
    @title ="Recent"
    
    projects = Project.where(slug: %w{members unite ledger})
    releases = Release.where(project_id: projects.map(&:id)).limit(20)
    @changes = releases.flat_map(&:release_changes).take(15)
    
    render partial: "houston/dashboards/issues/changes" if request.xhr?
  end
  
end

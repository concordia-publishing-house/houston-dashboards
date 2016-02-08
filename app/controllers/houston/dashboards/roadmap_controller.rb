class Houston::Dashboards::RoadmapController < ApplicationController
  layout "houston/dashboards/dashboard"

  def index
    today = Date.today
    @range = 6.months.before(today)..6.months.after(today)
    @milestones = RoadmapMilestone.during(@range)
    @show_today = params[:today] != "false"

    @title = "Roadmap"

    @sprint = Sprint.find_by_id(params[:sprint_id]) || Sprint.current || Sprint.create!

    respond_to do |format|
      format.html { render layout: "houston/roadmaps/dashboard" }
      format.json { render json: {
        start: @sprint.start_date,
        tasks: SprintTaskPresenter.new(@sprint).as_json,
        range: {start: @range.begin, end: @range.end},
        milestones: Houston::Roadmaps::RoadmapMilestonePresenter.new(@milestones) } }
    end
  end

end

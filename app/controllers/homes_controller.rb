class HomesController < ApplicationController

  def index
    q = params[:query].presence || "*"
    @visits = Visit.search(q, suggest: true)
  end

  def show
    @visits = Visit.all
  end

  def autocomplete
    render json: Visit.search(params[:term], fields: [{country: :text_start}], limit: 10).map(&:country)
  end

  def visits_by_day
    render json: Visit.group_by_day(:visited_at, format: "B %d, %Y").count
  end
end

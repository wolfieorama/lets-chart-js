class HomesController < ApplicationController

  def index
    q = params[:query].presence || "*"
    @visits = Visit.search(q)
  end

  def show
    @visits = Visit.all
  end

  def autocomplete
    render json: Visit.search(params[:query], autocomplete: true, limit: 10).map(&:country)
  end

  def visits_by_day
    render json: Visit.group_by_day(:visited_at, format: "B %d, %Y").count
  end
end

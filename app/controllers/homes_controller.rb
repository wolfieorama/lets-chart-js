class HomesController < ApplicationController

  def index
    if params[:query].present?
      @visits = Visit.search(params[:query])
    else
      @visits = Visit.all
    end
  end

  def show
    @visits = Visit.all
  end

  def visits_by_day
    render json: Visit.group_by_day(:visited_at, format: "B %d, %Y").count
  end
end

class HomesController < ApplicationController

  def index
    q = params[:query].presence || "*"
    @visits = Visit.search(q, suggest: true)
  end

  def show
    @visits = Visit.all

    @h = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(:name=>'John', :data=>[3, 20, 3, 5, 4, 10, -12 ,3, 5,6,7,7,80,9,9])
      f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )
    end
  end

  def autocomplete
    render json: Visit.search(params[:term], fields: [{country: :text_start}], limit: 10).map(&:country)
  end

  def visits_by_day
    render json: Visit.group_by_day(:visited_at, format: "B %d, %Y").count
  end
end

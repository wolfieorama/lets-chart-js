class HomesController < ApplicationController

  def index
    q = params[:query].presence || "*"
    @visits = Visit.search(q, suggest: true)
  end

  def show
    @visits = Visit.all

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Combination chart"})
      f.options[:xAxis][:categories] = ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
      f.labels(:items=>[:html=>"Total fruit consumption", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
      f.series(:type=> 'column',:name=> 'Jane',:data=> [3, 2, 1, 3, 4])
      f.series(:type=> 'column',:name=> 'John',:data=> [2, 3, 5, 7, 6])
      f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
      f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
      f.series(:type=> 'spline',:name=> 'Average', :data=> [3, 2.67, 3, 6.33, 3.33])
      f.series(:type=> 'pie',:name=> 'Total consumption',
      :data=> [
        {:name=> 'Jane', :y=> 13, :color=> 'red'},
        {:name=> 'John', :y=> 23,:color=> 'green'},
        {:name=> 'Joe', :y=> 19,:color=> 'blue'}
      ],
      :center=> [100, 80], :size=> 100, :showInLegend=> false)
     end

    @h = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Test line chart"})
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

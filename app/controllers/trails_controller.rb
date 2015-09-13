class TrailsController < ApplicationController
  before_action :trail, only: :show

  def index
    @trails = Trail.all
  end


  def new
    @trail = Trail.new
  end

  def show
    @car_trip_duration = Trips::Car.duration(trail)
    @bus_trip_duration = Trips::Bus.duration(trail)
    get_weather_stats(trail)

    @main = JSON.parse(@weather_response.body)['weather'].first['main']
    @temperature = JSON.parse(@weather_response.body)['main'].first.second - 273.15
    if @main == "Rain" || @temperature < 15
      @jak = "przy chujowej pogodzie"
    else
      @jak = "czy Ty musisz być takim leniem, napierdalaj na piechotę"
    end

    @jak
  end

  def create
    @trail = Trail.new(trail_params)
    if @trail.save!
      flash[:notice] = t('trails.new_trails_created')
      redirect_to trail_path(@trail)
    else
      render :new
    end
  end

  def get_weather_stats(trail_params)
    @weather_response = Excon.get("http://api.openweathermap.org/data/2.5/weather?q=#{trail.start_point_city}")
  end

  private

  def trail
    @trail ||= Trail.find(params[:id])
  end

  def trail_params
    params.require(:trail).permit!
  end
end

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
    get_weather_stats(trail)

    @main = JSON.parse(@weather_response.body)['weather'].first['main']
    @temperature = JSON.parse(@weather_response.body)['main'].first.second - 273.15
    if @main == "Rain" || @temperature < 15
      @jak = "przy chujowej pogodzie"
    else
      @jak = "czy Ty musisz być takim leniem, napierdalaj na piechotę"
    end

    @jak
    bus_trip_duration(trail)
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

  def bus_trip_duration(trail_params)
    @bus_trip_response = Excon.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{trail_params[:start_point_number]}+#{trail_params[:start_point_street]}+#{trail_params[:start_point_city]}&destination=#{trail_params[:end_point_number]}+#{trail_params[:end_point_street]}+#{trail_params[:end_point_city]}&mode=transit&departure_time=1415369556&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s")
    @bus_trip_duration = JSON.parse(@bus_trip_response.body)['routes'].first['legs'].first['duration']['text']
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

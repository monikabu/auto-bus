class TrailsController < ApplicationController
  #Excon.defaults[:uri_parser] = Addressable::URI

  def index
    @trails = Trail.all
  end


  def new
    @trail = Trail.new
  end

  def show
    @trail = Trail.find(params[:id])
    trail_params = {
      start_point_city: @trail.start_point_city,
      start_point_street: @trail.start_point_street,
      start_point_number: @trail.start_point_number,
      end_point_city: @trail.end_point_city,
      end_point_street: @trail.end_point_street,
      end_point_number: @trail.end_point_number
    }
    @car_trip_duration = Trail.trip_duration(trail_params)
    get_weather_stats(trail_params)

    @main = JSON.parse(@weather_response.body)['weather'].first['main']
    @temperature = JSON.parse(@weather_response.body)['main'].first.second - 273.15
    if @main == "Rain"
      @jak = "chujowo, bo pada"
      if @temperature < 20
        @jak = @jak + " i pizga"
      end
    else
      @jak = "czy Ty musisz być takim leniem, napierdalaj na piechotę"
    end

    @jak
    bus_trip_duration(trail_params)
    if @bus_trip_duration < @car_trip_duration
      @czym = 'dziś niestety musisz się pointegrować z plebsem - wycieczka autobusem będzie szybszą opcją'
    else
      @czym = 'nie bądź głupi, jedź autem'
    end
    @czym
  end

  def create
    @trail = Trail.new(trail_params)
    if @trail.save
      flash[:notice] = "Your trail was successfully created"
      redirect_to trails_path
    else
      render "new"
    end
  end

  def bus_trip_duration(trail_params)
    @bus_trip_response = Excon.get("https://maps.googleapis.com/maps/api/directions/json?origin=#{trail_params[:start_point_number]}+#{trail_params[:start_point_street]}+#{trail_params[:start_point_city]}&destination=#{trail_params[:end_point_number]}+#{trail_params[:end_point_street]}+#{trail_params[:end_point_city]}&mode=transit&departure_time=1415369556&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s")
    @bus_trip_duration = JSON.parse(@bus_trip_response.body)['routes'].first['legs'].first['duration']['text']
  end

  # def get_georeferences(trail_params)
  #  @start_point_response ||= Excon.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{trail_params[:start_point_number]}+#{trail_params[:start_point_street]}+#{trail_params[:start_point_city]}&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s")
  #   @end_point_response ||= Excon.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{trail_params[:end_point_number]}+#{trail_params[:end_point_street]}+#{trail_params[:end_point_city]}&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s")
  #   @s_p_ln = JSON.parse(@start_point_response.body)['results'].first['geometry']['location']['lng']
  #   @s_p_lat = JSON.parse(@start_point_response.body)['results'].first['geometry']['location']['lat']
  #   @e_p_ln = JSON.parse(@end_point_response.body)['results'].first['geometry']['location']['lng']
  #   @e_p_lat = JSON.parse(@end_point_response.body)['results'].first['geometry']['location']['lat']
  # end

  def get_weather_stats(trail_params)
    @weather_response = Excon.get("http://api.openweathermap.org/data/2.5/weather?q=#{trail_params[:start_point_city]}")
  end

  private

  def trail_params
    params.require(:trail).permit(:name, :start_point_city, :start_point_street, :start_point_number, :end_point_city, :end_point_strret, :end_point_number)
  end

  def format_weather(weather)

  end
end

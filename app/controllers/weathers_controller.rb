class WeathersController < ActionController::Base

  def index
    Weather.last
    @weathers = get_weather_stats
    throw @weathers
  end

  def get_weather_stats
    Excon.get("http://api.openweathermap.org/data/2.5/weather?lat=52&lon=21")
  end
end

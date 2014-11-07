class Weather < ActiveRecord::Base
  def self.get_weather_stats()
    Excon.get("http://api.openweathermap.org/data/2.5/weather?lat=52&lon=21")
    api.openweathermap.org/data/2.5/weather?q=London,uk
  end
end

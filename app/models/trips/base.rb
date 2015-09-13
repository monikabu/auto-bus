class Trips::Base

  def self.duration(trail)
    response = Excon.get(trip_url(trail))
    trip_duration(response)
  end

  def self.api_base_url
    'https://maps.googleapis.com/maps/api'
  end
end

class Trips::Car < Trips::Base

  def self.duration(trail)
    response = get(duration_url(trail))
    trip_duration(response)
  end

  def self.duration_url(trail)
    "#{api_base_url}/json?#{origins(trail)}&mode=driving&language=en-EN&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s"
  end

  def self.api_base_url
    'https://maps.googleapis.com/maps/api/distancematrix'
  end

  def self.origins(trail)
    "origins=#{trail.start_point_number}+" +
    "#{trail.start_point_street}+" +
    "#{trail.start_point_city}" +
    "&destinations=#{trail.end_point_number}+" +
    "#{trail.end_point_street}+" +
    "#{trail.end_point_city}"
  end

  def self.trip_duration(response)
    JSON.parse(response.body)['rows'].
      first['elements'].
      first['duration']['text']
  end
end

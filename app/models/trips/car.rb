class Trips::Car < Trips::Base

  def self.trip_url(trail)
    "#{api_base_url}/distancematrix/json?#{origins(trail)}&mode=driving&language=en-EN&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s"
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

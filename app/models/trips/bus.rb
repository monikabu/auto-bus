class Trips::Bus < Trips::Base

  def self.trip_url(trail)
    "#{api_base_url}/directions/json?#{origins(trail)}&mode=transit&departure_time=#{Time.current.to_i}&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s"
  end

  def self.origins(trail)
    "origin=#{trail.start_point_number}+" +
    "#{trail.start_point_street}+" +
    "#{trail.start_point_city}" +
    "&destination=#{trail.end_point_number}+" +
    "#{trail.end_point_street}+" +
    "#{trail.end_point_city}"
  end

  def self.trip_duration(response)
    JSON.parse(response.body)['routes'].
      first['legs'].
      first['duration']['text']
  end
end

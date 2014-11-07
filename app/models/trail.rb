class Trail < ActiveRecord::Base
  def self.trip_duration(trail_params)
    response = Excon.get "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{trail_params[:start_point_number]}+#{trail_params[:start_point_street]}+#{trail_params[:start_point_city]}&destinations=#{trail_params[:end_point_number]}+#{trail_params[:end_point_street]}+#{trail_params[:end_point_city]}&mode=driving&language=en-EN&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s"
    JSON.parse(response.body)['rows'].first['elements'].first['duration']['text']
  end
end

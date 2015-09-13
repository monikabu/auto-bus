# == Schema Information
#
# Table name: trails
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  start_point_city   :string(255)
#  start_point_street :string(255)
#  start_point_number :string(255)
#  end_point_city     :string(255)
#  end_point_street   :string(255)
#  end_point_number   :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Trail < ActiveRecord::Base
  validates_presence_of :start_point_city
  validates_presence_of :start_point_number
  validates_presence_of :start_point_street
  validates_presence_of :end_point_city
  validates_presence_of :end_point_street
  validates_presence_of :end_point_number

  def self.trip_duration(trail_params)
    car_trip_response = Excon.get "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{trail_params[:start_point_number]}+#{trail_params[:start_point_street]}+#{trail_params[:start_point_city]}&destinations=#{trail_params[:end_point_number]}+#{trail_params[:end_point_street]}+#{trail_params[:end_point_city]}&mode=driving&language=en-EN&key=AIzaSyBeilkitrb2rF6u0GYvrbdPhM9qtWgC0_s"
    JSON.parse(car_trip_response.body)['rows'].first['elements'].first['duration']['text']
  end
end

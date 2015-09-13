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
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :start_point_city
  validates_presence_of :start_point_number
  validates_presence_of :start_point_street
  validates_presence_of :end_point_city
  validates_presence_of :end_point_street
  validates_presence_of :end_point_number
end

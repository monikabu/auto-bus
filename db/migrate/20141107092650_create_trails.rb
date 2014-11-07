class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string   "name"
      t.string   "start_point_city"
      t.string   "start_point_street"
      t.string   "start_point_number"
      t.string   "end_point_city"
      t.string   "end_point_street"
      t.string   "end_point_number"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end

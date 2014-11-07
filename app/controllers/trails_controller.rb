class TrailsController < ActionController::Base
  #Excon.defaults[:uri_parser] = Addressable::URI

  def index
    @trail = Trail.last
  end


  def new
    @trail = Trail.new
  end

  def show
    @trail = Trail.find(params[:id])
    trail_params = {
      start_point_city: @trail.start_point_city,
      start_point_street: @trail.start_point_street,
      start_point_number: @trail.start_point_number,
      end_point_city: @trail.end_point_city,
      end_point_street: @trail.end_point_street,
      end_point_number: @trail.end_point_number
    }
    @car_trip_duration = Trail.trip_duration(trail_params)
    @weather = Weather.get_current_weather(trail_params)
  end

  def create
    @trail = Trail.new(trail_params)
      if @trail.save
        flash[:notice] = "Your trail was successfully created"
        redirect_to trails_path
      else
        render "new"
      end
  end

  private

  def trail_params
    params.require(:trail).permit(:name, :start_point_city, :start_point_street, :start_point_number, :end_point_city, :end_point_strret, :end_point_number)
  end
end

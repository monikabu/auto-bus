class TrailsController < ApplicationController
  before_action :trail, only: :show

  def index
    @trails = Trail.all
  end

  def new
    @trail = Trail.new
  end

  def show
    @car_trip_duration = Trips::Car.duration(trail)
    @bus_trip_duration = Trips::Bus.duration(trail)
    @weather_conditions = Weather.conditions(trail)
  end

  def create
    @trail = Trail.new(trail_params)
    if @trail.save!
      flash[:notice] = t('trails.new_trails_created')
      redirect_to trail_path(@trail)
    else
      render :new
    end
  end

  private

  def trail
    @trail ||= Trail.find(params[:id])
  end

  def trail_params
    params.require(:trail).permit!
  end
end

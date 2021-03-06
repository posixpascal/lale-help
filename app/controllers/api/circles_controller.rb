class Api::CirclesController < ApplicationController
  layout false
  skip_authorization_check

  def index
    @center = params[:location].present? ? Location.location_from(params[:location]) : current_user.location
    locations = Location.near(@center).to_a
    @circles = Circle.where(location: locations.uniq)
  end
end
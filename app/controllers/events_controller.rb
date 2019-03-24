class EventsController < ApplicationController
  include EventsHelper

  def index
  	@events = Event.all
    build_geojson(@events)

    respond_to do |format|
    	format.html
    	format.json { render json: @geojson }
    end
  end
end

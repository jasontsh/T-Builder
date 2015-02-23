class EventsController < ApplicationController
  def new
  	@event = Event.new
  end


  def index
  	@event = Event.all
  end
end

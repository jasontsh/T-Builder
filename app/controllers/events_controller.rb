class EventsController < ApplicationController
  def new
    if user_sign_in?
  	  @event = Event.new
    else 
      redirect_to new_user_session_path
    end
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def index
    if user_sign_in?
  	  @events = Event.all
    else 
      @events = []
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to event_path(@event.id)
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name)
  end
end

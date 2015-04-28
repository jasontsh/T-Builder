class EventsController < ApplicationController
  def new
    if user_signed_in?
  	  @event = Event.new
      @event.userid = current_user.id
    else 
      redirect_to new_user_session_path
    end
  end

  def create
    @event = Event.new(event_params)
    @event.userid = current_user.id
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def index
    if user_signed_in?
  	  @events = Event.where({userid: current_user.id})
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

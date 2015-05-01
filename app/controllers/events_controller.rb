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
    @event = Event.new
    @event.userid = current_user.id
    @event.name = params[:name]
    s = params[:characteristics]
    s = s.downcase
    @event.characteristic = s
    e = params[:email_list]
    el = e.split(",")
    users = User.all
    el.each do |email|
      users.each do |u| 
        if u.email == email 
          rel = Relation.new({:userid => u.id, :eventid => @event.id, :status => 0})
          rel.save
        elsif u.id == current_user.id
          rel = Relation.new({:userid => u.id, :eventid => @event.id, :status => 2})
          rel.save
        end
      end
    end
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def index
    if user_signed_in?
      byebug
  	  @events = Event.where({userid: current_user.id})
    else 
      @events = []
    end
  end

  def show
    @event = Event.find(params[:id])
    relationlist = Relation.where({eventid: @event.id})
    @userlist = []
    @statuslist = []
    relationlist.each do |rel|
      user = User.where({id: rel.userid})
      @userlist << user.name
      if rel.status == 0
        @statuslist << "waiting for reply"
      elsif rel.status == 1
        @statuslist << "owner"
      else 
        @statuslist << "attending"
      end
    end
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
    params.require(:event).permit(:name, :characteristic)
  end
end

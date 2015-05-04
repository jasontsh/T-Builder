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
    if @event.save
      e = params[:email_list]
      el = e.split(",")
      users = User.all
      el.each do |email|
        users.each do |u| 
          if u.id == current_user.id
            rel = Relation.new({:userid => u.id, :eventid => @event.id, :status => 2})
            rel.save
          elsif u.email == email 
            rel = Relation.new({:userid => u.id, :eventid => @event.id, :status => 0})
            Invitations.new_invite(current_user.name, email).deliver
            rel.save
          end
        end
      end
      redirect_to events_path
    else
      render 'new'
    end
  end

  def index
    if user_signed_in?
      el = Event.all
      @events = []
      rellist = Relation.where({userid: current_user.id})
      rellist.each do |rel|
        e = Event.where({id: rel.eventid})
        if e != nil
          @events << e
        end
      end
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
      @userlist << user.first
      if rel.status == 0
        @statuslist << "waiting for reply"
      elsif rel.status == 1
        @statuslist << "attending"
      else 
        @statuslist << "owner"
      end
    end
    relation = Relation.where({userid: current_user.id, eventid: @event.id})
    @status = relation.first.status
  end

  def edit
    if @status == 1
      redirect_to event_path(params[:id])
    end
    @event = Event.find(params[:id])
    relation = Relation.where({userid: current_user.id, eventid: @event.id})
    this_relation = relation.first
    if this_relation.status == 0
      this_relation.status = 1
      this_relation.save
    end
    @status = params[:status]
    user = current_user
    @show = {}
    characteristic = user.characteristic
    if characteristic.nil?
      characteristic = "{}"
    end
    char = ActiveSupport::JSON.decode(characteristic)
    char_needed = @event.characteristic.split(",")
    char_needed.each do |c|
      @show[c] = char[c]
    end
    char.each do |k, v|
      @show[k] = v
    end
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
    relationlist = Relation.where({eventid: @event.id})
    relationlist.each do |rel|
      rel.destroy
    end
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :characteristic)
  end
end

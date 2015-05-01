class RelationsController < ApplicationController
  def new

  end

  def create
  	@relation = Relation.new(relation_param)
  	if @relation.save
  	  redirect_to events_path
  	else
  	  redirect_to new_event_path
  	end
  end

  def destroy
  	@relation = Relation.find(params[:id])
    @relation.destroy
  end

  private
  def event_params
    params.require(:relation).permit(:userid, :eventid, :status)
  end
end

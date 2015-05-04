class UsersController < ApplicationController
  def new
	 @user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  	  redirect_to user_path(current_user)
  	else
  	  render 'new'
  	end
  end

  def index
  	if signed_in?
      redirect_to user_path(current_user)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    #if params[:id] == "sign_out"
    #  redirect_to destroy_user_session_path
    #else
      @user = User.find(params[:id])
    #end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to destroy_user_session_path
  end

  def update_characteristics
    current_user[:characteristic] = ActiveSupport::JSON.encode(params[:characteristic])
    current_user.save
    redirect_to event_path(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end

class Characteristic
  attr_accessor :clist, :jstring
  def initialize(json)
    @jstring = json
    byebug
    @clist = ActiveSupport::JSON.decode{json}
  end

  def getJsonValue(key)
    return @clist[:key]
  end

  def getList()
    return @clist
  end
end
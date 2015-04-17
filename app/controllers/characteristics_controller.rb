class CharacteristicsController < ApplicationController
  def new
    if user_sign_in?
      @characteristic = Characteristic.new
    else 
      redirect_to new_user_session_path
    end
  end

  def create
    @characteristic = Characteristic.new(user_params)
  if @characteristic.save
    redirect_to characteristics_path
  else
    render 'new'
  end
  end


  def index
    if user_sign_in
      @characteristic = Characteristic.all
    else 
      @characteristic = []
    end
  end

  def show
    @characteristic = Characteristic.find(params[:id])
  end

  def edit
    @characteristic = Characteristic.find(params[:id])
  end

  def update
    @characteristic = Characteristic.find(params[:id])
    if @characteristic.update_attributes(characteristic_params)
      redirect_to characteristic_path(@characteristic.id)
    else
      render 'edit'
    end
  end

  def destroy
    @characteristic = Characteristic.find(params[:id])
    @characteristic.destroy
    redirect_to characteristics_path
  end

  private

  def user_params
    params.require(:characteristic).permit(:name, :value)
  end
end

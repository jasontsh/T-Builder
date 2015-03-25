class AttributesController < ApplicationController
  def new
	@attribute = Attribute.new
  end

  def create
	@attribute = Attribute.new(user_params)
	if @attribute.save
	  redirect_to attribute_path
	else
	  render 'new'
	end
  end

  def index
	@attributes= Attribute.all
  end

  def show
    @attribute = Attribute.find(params[:id])
  end

  def edit
    @attribute = Attribute.find(params[:id])
  end

  def update
    @attribute = Attribute.find(params[:id])
    if @attribute.update_attributes(attribute_params)
      redirect_to attribute_path(@attribute.id)
    else
      render 'edit'
    end
  end

  def destroy
    @attribute = Attribute.find(params[:id])
    @attribute.destroy
    redirect_to attributes_path
  end

  private

  def user_params
    params.require(:attribute).permit(:name, :value)
  end
end

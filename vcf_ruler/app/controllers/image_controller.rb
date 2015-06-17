class ImageController < ApplicationController
  def index
  end

  def new
  end

  def show
    @id = params[:id]
    @image = Image.find(@id)
  end

  def create
    @image = Image.new( user_params )
    if @image.save
      redirect_to :action => :show, :id => @image.id
    end
  end


  private

  def user_params
    params.require(:image).permit(:image)
  end
end

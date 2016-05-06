class PinsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def show
    @pin = Pin.find(params[:id])
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    pin = current_user.pins.build(pin_params)
    if pin.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def pin_params
    params.require(:pin).permit(:description, :image)
  end
end
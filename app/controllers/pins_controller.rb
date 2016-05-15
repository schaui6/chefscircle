class PinsController < ApplicationController

  def index
  end

  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.new(pin_params)
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :descriptionå)
  end

end

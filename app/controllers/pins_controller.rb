class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pins = Pin.all.order("created_at DESC")
  end

  def show
    pin = Pin.find_by(id: params[:id])
    phrase = pin.rececipe_name_with_serving_size
    nutritionx_response = Unirest.get "https://nutritionix-api.p.mashape.com/v1_1/search/#{phrase}?fields=item_name%2Citem_id%2Cbrand_name%2Cnf_calories%2Cnf_total_fat",
    headers:{
      "X-Mashape-Key" => ENV['NUTRIIONX_API'],
      "Accept" => "application/json"
    }

    @recipes = JSON.parse(nutritionx_response.raw_body)
    @recipe = @recipes['hits'].first
  end

  def new
    @pin = current_user.pins.build
  end

  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save
      redirect_to @pin, notice: "Recipe was successfully created"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: "Recipe was successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to root_path
  end

  def upvote
    @pin.upvote_by current_user
    redirect_to :back
  end

  private

  def pin_params
    params.require(:pin).permit(:rececipe_name_with_serving_size, :description, :ingredients, :image)
  end

  def find_pin
    @pin = Pin.find(params[:id])
  end

end

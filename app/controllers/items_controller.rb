class ItemsController < ApplicationController

  def index
    # @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    item.create(item_params)
    redirect_to '/'
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :text)
  end

end

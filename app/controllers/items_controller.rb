class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    # @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # 出品が成功した場合
      redirect_to root_path, notice: '商品を出品しました。'
    else
      # 入力に問題がある場合
      render :new, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:item_name, :description, :price, :category_id, :condition_id, :shipping_detail_id, :prefecture_id, :shipping_timeframe_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end

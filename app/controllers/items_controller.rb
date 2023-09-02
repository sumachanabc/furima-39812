class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.all.order(created_at: :desc)
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

  def show
  end

  def edit
    return if @item.user == current_user
    redirect_to root_path
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :price, :category_id, :condition_id, :shipping_detail_id,
                                 :prefecture_id, :shipping_timeframe_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return if user_signed_in?

    redirect_to new_user_session_path
  end
end

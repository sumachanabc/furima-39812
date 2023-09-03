class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_tokutei, only: [:index, :create]

  def index
    @order_shipping_address = OrderShippingAddress.new
    # ★Formオブジェクトのインスタンスをform_withのmodelオプションに指定。
    # index(カリキュラムはnew)アクションで生成するインスタンス変数は、index.html.erb内でも使用可能。
    # index(カリキュラムはnew)アクションで生成したインスタンスは、form_withのmodelオプションに指定可能。
    # ⇒Formオブジェクトのインスタンスに紐付いたフォームを作成可能。
  end

  def create
    @order_shipping_address = OrderShippingAddress.new(order_params)
    if @order_shipping_address.valid?# valid?メソッドを使用しているのは、OrderShippingAddressクラスがApplicationRecordを継承していないことにより、saveメソッドにはバリデーションを実行する機能がないため
      @order_shipping_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def item_tokutei
    @item = Item.find(params[:item_id])
  end

  def pay_item
  end

end

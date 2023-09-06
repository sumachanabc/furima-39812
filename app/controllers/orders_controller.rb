class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_tokutei, only: [:index, :create, :pay_item]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping_address = OrderShippingAddress.new
    @item = Item.find(params[:item_id]) # item_tokutei メソッドの代わりに直接 item を取得
    if user_can_purchase?
      render :index
    else
      redirect_to root_path
    end
  end

  def create
    gon.public_key = ENV['PAYJP_PUBLIC_KEY'] # 環境変数を使用して公開鍵を代入。RailsからJavaScriptへ公開鍵を渡す
    @order_shipping_address = OrderShippingAddress.new(order_params)

    # 条件分岐を追加して、要件に合わせたリダイレクトを行う
    if user_can_purchase? && @order_shipping_address.valid? # valid?メソッドを使用しているのは、OrderShippingAddressクラスがApplicationRecordを継承していないことにより、saveメソッドにはバリデーションを実行する機能がないため
      pay_item
      @order_shipping_address.save # saveの定義はモデル
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity # バリデーションに引っかかった場合は、indexアクションが実行されることなくindex.html.erbがrenderされるため、別途gonの設定が必要。
    end
  end

  private

  def order_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def item_tokutei
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述
    item_price = @item.price
    Payjp::Charge.create(
      amount: item_price, # 商品の値段
      card: order_params[:token], # トークン化されたカード情報
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def user_can_purchase?
    if current_user == @item.user # 購入が許可されるかどうかの条件分岐を実装
      false # 自身が出品した商品の場合はトップページにリダイレクト
    elsif @item.sold?
      false # 売却済み商品の場合はトップページにリダイレクト
    else
      true # ログアウト状態の場合はログインページにリダイレクト
    end
  end
end

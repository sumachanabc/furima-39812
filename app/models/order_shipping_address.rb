class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :user_id, :item_id,:token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"} # 数字3桁、ハイフン、数字4桁の並びのみ許可する
    validates :phone_number, format: { with: /\A\d+\z/, message: "は半角数字のみ入力してください" }, length: { minimum: 10, maximum: 11, message: "は10桁または11桁で入力してください" }
  end
  validates :prefecture_id, numericality: { other_than: 1 }# 0以外の整数を許可する

  def save
    # 購入情報を保存し、変数orderに代入する
    order = Order.create(user_id: user_id,item_id: item_id,token: token)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street_address: street_address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end

end
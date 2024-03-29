class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # module=特定の役割を持つメソッドや定数に名前を付けてまとめたもの
  # ActiveHashを用いて、belongs_toを設定するには、extend ActiveHash::Associations::ActiveRecordExtensionsと記述してmoduleを取り込む必要がある。
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_detail, class_name: 'ShippingDetail', foreign_key: 'shipping_detail_id'
  belongs_to :prefecture, class_name: 'Prefecture', foreign_key: 'prefecture_id'
  belongs_to :shipping_timeframe, class_name: 'ShippingTimeframe', foreign_key: 'shipping_timeframe_id'
  has_one :order
  has_one_attached :image

  validates :item_name, presence: true
  validates :description, presence: true
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 }
  validates :shipping_detail_id, numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :shipping_timeframe_id, numericality: { other_than: 1 }
  validates :price, presence: true,
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 300,
                      less_than_or_equal_to: 9_999_999
                    }
  validates :image, presence: { message: 'を添付してください' }

  def sold?
    order.present? # 注文が存在すれば売却済みと判断
  end
end

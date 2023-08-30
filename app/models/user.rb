class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :orders

  # 名前(全角)のバリデーション
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: "は全角文字で入力してください" }
  validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: "は全角文字で入力してください" }

  # 名前カナ(全角)のバリデーション
  validates :read_first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "はカタカナで入力してください" }
  validates :read_family_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "はカタカナで入力してください" }

  # 生年月日のバリデーション
  validates :date_of_birth, presence: true
end

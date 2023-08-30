class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :orders

  validates :date_of_birth, presence: true
  validates :first_name, presence: true
  validates :family_name, presence: true
  validates :read_first_name, presence: true
  validates :read_family_name, presence: true
end

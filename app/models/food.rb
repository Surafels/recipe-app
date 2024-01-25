class Food < ApplicationRecord
  has_many :recipe_foods
  belongs_to :user

  validates :name, presence: true
  validates :measurment_unit, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
end

class Recipe < ApplicationRecord
  belongs_to :user
  has_many :steps, dependent: :destroy
  has_many :recipe_foods, dependent: :destroy, counter_cache: true
  has_many :foods, through: :recipe_foods
  accepts_nested_attributes_for :recipe_foods, allow_destroy: true
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, presence: true
  validates :description, presence: true
end

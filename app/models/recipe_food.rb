class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validate :quantity, presence: true
end

class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  accepts_nested_attributes_for :recipe_ingredients
  validates :name, uniqueness: { case_sensitive: false }
end

class Recipe < ApplicationRecord
  belongs_to :user
  scope :easy_difficulty_level, -> { where(difficulty_level: "Easy") }
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  accepts_nested_attributes_for :recipe_ingredients
  validates :name, presence: true
  validates :instructions, presence: true
  validates :user_id, presence: true
  

  # def recipe_ingredients_attributes=(ingredient)
  #   # byebug
  #   self.recipe_ingredients = Ingredient.find_or_create_by(name: ingredient[:name])
  #   self.recipe_ingredients.update(ingredient)
  # end

  #   def recipe_ingredients_attributes=(ingredients)
  #     self.recipe_ingredients << RecipeIngredient.where(ingredients).first_or_initialize
  #  end

  # def ingredient_attributes=(ingredient)
  #   self.ingredient = Ingredient.find_or_create_by(name: ingredient[:name])
  #   self.ingredient.update(ingredient)
  # end
  # def recipe_ingredients_attributes=(recipe_ingredient_attributes)
  #   recipe_ingredient_attributes.values.each do |ingredient_name|
  #     recipe_ingredient = Ingredient.find_or_create_by(name)
  #     self.ingredients << ingredient
  #   end
  # end
end

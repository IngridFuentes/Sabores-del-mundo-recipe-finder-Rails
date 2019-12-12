class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :instructions, presence: true, length: {maximum: 300}
  validates :user_id, presence: true
end

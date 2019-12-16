class Recipe < ApplicationRecord
  belongs_to :user

  # scope :created_before, ->(time) { where("created_at < ?", time) }
  scope :easy_difficulty_level, -> { where(difficulty_level: "Easy") }
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  accepts_nested_attributes_for :ingredients

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :instructions, presence: true
  validates :user_id, presence: true
end

class RecipeIngredientsController < ApplicationController
  before_action :set_recipe_ingredient, only: [:show, :edit, :update]

  def index
    @recipe_ingredients = RecipeIngredient.all
  end

  def show
    
  end

  def new
    @recipe_ingredient = RecipeIngredient.new
  end

  def create
    @recipe_ingredient = RecipeIngredient.find_or_create_by(recipe_ingredient_params)
  end

  def edit
  end

  def update
    @recipe_ingredient.update(recipe_ingredient_params)
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :quantity, ingredients_attributes: [:name, :ingredient_id])
  end

  def set_recipe_ingredient
    @recipe_ingredient = RecipeIngredient.find(params[:id])
  end
end

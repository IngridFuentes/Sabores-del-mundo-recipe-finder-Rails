class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    5.times { @recipe.recipe_ingredients.build }
  end

  def create
   
    @recipe = current_user.recipes.build(recipe_params)
  #  byebug
    # @recipe.user_id = current_user.id if logged_in?

    if @recipe.save
      flash[:success] = "Added Recipe"
      redirect_to user_path(current_user)
    else
      # byebug
      render :new
    end
  end

  def edit
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user.nil?
        redirect_to users_path, alert: "User not found."
      else
        @recipe = user.recipes.find_by(id: params[:id])
        redirect_to user_recipes_path(user), alert: "Recipe not found." if @recipe.nil?
      end
    else
      @recipe = Recipe.find(params[:id])
    end
  end

  def update
    # byebug
    @recipe.update(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    user = User.find_by(id: params[:user_id])
    @recipe.destroy
    flash[:notice] = "Recipe deleted."
    redirect_to user_path(current_user)
  end

  def easy_recipes
    Recipe.easy_difficulty_level
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :instructions, :difficulty_level, :user_id, ingredients_attributes: [:id, :name], recipe_ingredients_attributes:[:quantity, :id, :ingredient_id])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_same_user
    if current_user != @recipe.user
      flash[:danger] = " You can only edit or delete your own recipe"
      redirect_to root_path
    end
  end
end

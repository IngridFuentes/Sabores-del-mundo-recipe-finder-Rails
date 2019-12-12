class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :destroy]

  def index
    # if params[:user_id]
    #   @user = User.find_by(id: params[:user_id])
    #   if @user.nil?
    #     redirect_to users_path, alert: "User not found"
    #   else
    #     @recipe = @user.recipes
    #   end
    # else
    # @recipes = Recipe.where(creator_id: current_user.id).
    #   limit(PER_PAGE).offset(PER_PAGE * page)
    # end
    @recipes = Recipe.all
  end

  def show
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @recipe = @user.recipes.find_by(id: params[:id])
      if @recipe.nil?
        redirect_to user_recipes_path(@user), alert: "Recipe not found"
      end
    else
      @recipe = Recipe.find(params[:id])
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    @recipe.creator_id = current_user.id if logged_in?

    if @recipe.save
      flash[:success] = "Added Recipe"
      redirect_to recipe_path(@recipe)
    else
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
    @recipe.update(recipe_params)

    if @recipe.save
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash[:notice] = "Recipe deleted."
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :instructions, :difficulty_level, :user_id)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end

class RemoveQuantityFromRecipeIngredients < ActiveRecord::Migration[6.0]
  def change

    remove_column :recipe_ingredients, :quantity, :string
  end
end

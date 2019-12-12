class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.integer :user_id
      t.string :name
      t.string :instructions
      t.string :difficulty_level

      t.timestamps
    end
  end
end

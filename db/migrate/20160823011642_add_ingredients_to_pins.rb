class AddIngredientsToPins < ActiveRecord::Migration
  def change
    add_column :pins, :ingredients, :text
  end
end

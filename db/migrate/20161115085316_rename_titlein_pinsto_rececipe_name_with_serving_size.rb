class RenameTitleinPinstoRececipeNameWithServingSize < ActiveRecord::Migration
  def change
    rename_column :pins, :title, :rececipe_name_with_serving_size
  end
end

class ChangeImagenesToBeJsonInProductos < ActiveRecord::Migration[8.0]
  def change
    change_column :productos, :imagenes, :json
  end
end

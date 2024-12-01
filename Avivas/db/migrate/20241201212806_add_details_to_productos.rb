class AddDetailsToProductos < ActiveRecord::Migration[8.0]
  def change
    change_table :productos do |t|
      t.string :talle
      t.string :color_id
      t.datetime :fecha_ingreso
      t.datetime :fecha_modificacion
      t.datetime :fecha_baja
      t.json :imagenes 
    end
  end
end

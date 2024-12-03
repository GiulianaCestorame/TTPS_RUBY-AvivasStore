class CreateVenta < ActiveRecord::Migration[8.0]
  def change
    create_table :venta do |t|
      t.datetime :fecha_hora
      t.decimal :total
      t.references :user, null: false, foreign_key: true
      t.references :cliente, null: false, foreign_key: true
      t.boolean :active , default:true

      t.timestamps
    end
  end
end

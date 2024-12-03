class AddDefaultActiveToVentas < ActiveRecord::Migration[8.0]
  def change
    change_column_default :venta, :active, from: nil, to: true
  end
end

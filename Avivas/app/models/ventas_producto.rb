class VentasProducto < ApplicationRecord
  belongs_to :venta
  belongs_to :producto

  validates :cantidad, :precio_venta, presence: true
  
end

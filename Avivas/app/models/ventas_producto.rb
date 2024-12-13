class VentasProducto < ApplicationRecord
  belongs_to :venta
  belongs_to :producto

  validates :cantidad, presence: true
  
end

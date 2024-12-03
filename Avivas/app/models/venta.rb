class Venta < ApplicationRecord
  belongs_to :user
  belongs_to :cliente

  has_many :ventas_productos, dependent: :destroy
  has_many :productos, through: :ventas_productos

  validates :fecha_hora, :total, :user_id, presence: true
  accepts_nested_attributes_for :ventas_productos, allow_destroy: true

  before_create :calculate_total
  before_create :check_stock

  private

  def calculate_total
    self.total = ventas_productos.sum { |vp| vp.cantidad * vp.precio_venta }
  end

  def check_stock
    ventas_productos.each do |vp|
      producto = Producto.find(vp.producto_id)
      if producto.stock < vp.cantidad
        errors.add(:base, "Stock insuficiente para #{producto.nombre}")
        throw(:abort)
      end
    end
  end

  
end







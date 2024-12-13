class Venta < ApplicationRecord
  belongs_to :user
  belongs_to :cliente

  has_many :ventas_productos, dependent: :destroy
  has_many :productos, through: :ventas_productos

  accepts_nested_attributes_for :ventas_productos, allow_destroy: true

  validates :total, :user_id, presence: true

  before_create :check_stock
  before_create :set_fechayhora

  private



  def check_stock
    ventas_productos.each do |vp|
      producto = Producto.find(vp.producto_id)
      if producto.stock < vp.cantidad
        errors.add(:base, "Stock insuficiente para #{producto.nombre}")
        throw(:abort)
      end
    end
  end

  def set_fechayhora
    self.fecha_hora = DateTime.now 
  end 


  
end







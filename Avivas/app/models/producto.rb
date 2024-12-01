class Producto < ApplicationRecord
  belongs_to :categoria
  belongs_to :color
  mount_uploaders :imagenes, ImagenUploader 
  #serialize :imagenes, JSON


  validates :nombre, :precio, :stock, presence: true
  validates :precio, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }


  before_save :set_fecha_ingreso 
  before_save :set_fecha_modificacion 
  before_destroy :soft_delete

  private 
  def set_fecha_ingreso
     self.fecha_ingreso ||= DateTime.now 
    end 
  def set_fecha_modificacion 
    self.fecha_modificacion = DateTime.now 
  end 
  def soft_delete 
    self.update(stock: 0, fecha_baja: DateTime.now) 
    throw(:abort) # Previene la destrucción física del registro
  end

end

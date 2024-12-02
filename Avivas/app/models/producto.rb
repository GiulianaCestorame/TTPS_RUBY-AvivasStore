class Producto < ApplicationRecord
  belongs_to :categoria
  belongs_to :color
  mount_uploaders :imagenes, ImagenUploader 


  validates :nombre, :descripcion, :precio, :stock, :imagenes, :categoria_id, presence: true 
  validates :descripcion, length: { maximum: 255, message: "no puede tener más de 255 caracteres"}
  validates :precio, numericality: { greater_than_or_equal_to: 0 } 
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 } 
  validates :imagenes, length: { minimum: 1, message: "debe contener al menos una imagen"}


  before_save :set_fecha_ingreso 
  before_save :set_fecha_modificacion 

  def soft_delete 
    self.update(stock: 0, fecha_baja: DateTime.now) 
  end

  private 
  def set_fecha_ingreso
     self.fecha_ingreso ||= DateTime.now 
    end 
  def set_fecha_modificacion 
    self.fecha_modificacion = DateTime.now 
  end 


end

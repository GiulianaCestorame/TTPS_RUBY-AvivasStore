class Producto < ApplicationRecord
  belongs_to :categoria
  mount_uploader :imagen, ImagenUploader
  validates :nombre, :precio, :stock, presence: true
  validates :precio, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end

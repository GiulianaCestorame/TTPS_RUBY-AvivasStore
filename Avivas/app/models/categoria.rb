class Categoria < ApplicationRecord
  has_many :productos
  validates :nombre, presence: true
end

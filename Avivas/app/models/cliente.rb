class Cliente < ApplicationRecord
    has_many :ventas 

    validates :phone, presence: true, format: { with: /\A\d{6,10}\z/, message: "El telefono debe tener entre 6 y 10 numeros" }
    validates :nombre, presence: true, length: { maximum: 100 }
    validates :apellido, presence: true, length: { maximum: 100 }
    validates :dni, presence: true, uniqueness: true, length: { in: 7..10 }, format: { with: /\A\d+\z/, message: "solo puede contener números" }

    
    def nombre_completo 
        "#{nombre} #{apellido}" 
    end
end

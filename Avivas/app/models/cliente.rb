class Cliente < ApplicationRecord
    has_many :ventas 
    
    def nombre_completo 
        "#{nombre} #{apellido}" 
    end
end

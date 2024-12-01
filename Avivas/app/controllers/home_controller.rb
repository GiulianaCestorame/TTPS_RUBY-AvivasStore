class HomeController < ApplicationController

# index de productos
def index
  # Filtrar productos según la categoría seleccionada
  @user = current_user
  if params[:categoria].present?
    @productos = Producto.where(categoria_id: params[:categoria])
  else
    @productos = Producto.all
  end

  # Búsqueda por nombre o descripción
  if params[:q].present?
    @productos = @productos.where('LOWER(nombre) LIKE ? OR LOWER(descripcion) LIKE ?', "%#{params[:q].downcase}%", "%#{params[:q].downcase}%")
  end

  @categorias = Categoria.all
end


end

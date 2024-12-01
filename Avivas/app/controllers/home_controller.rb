class HomeController < ApplicationController
  def index
    puts("se llamo a la funcion index del controlador home")
    @user = current_user
  end

#index de productos 
  def index
    # Filtrar productos según la categoría seleccionada
    if params[:categoria].present?
      @productos = Producto.where(categoria_id: params[:categoria])
    else
      @productos = Producto.all
    end

    # Búsqueda por nombre o descripción
    if params[:q].present?
      @productos = @productos.where('nombre ILIKE ? OR descripcion ILIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")
    end

    @categorias = Categoria.all
  end

end

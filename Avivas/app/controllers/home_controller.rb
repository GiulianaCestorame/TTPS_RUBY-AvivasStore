class HomeController < ApplicationController

# index de productos
  def index
    @user = current_user
    if params[:categoria].present?
      @productos = Producto.where(categoria_id: params[:categoria])
    else
      @productos = Producto.all
    end

  if params[:q].present?
    @productos = @productos.where('LOWER(nombre) LIKE ? OR LOWER(descripcion) LIKE ?', "%#{params[:q].downcase}%", "%#{params[:q].downcase}%")
  end
  
  @productos = @productos.where('stock > ?', 0) 
  @categorias = Categoria.all
end


end

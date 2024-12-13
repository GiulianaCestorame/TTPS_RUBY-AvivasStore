class ProductosController < ApplicationController
  before_action :authenticate_user!

  def index
    @productos = Producto.where('stock > ?', 0)
  end
  
  def new
    @producto = Producto.new
  end
  
  def create
    @producto = Producto.new(producto_params)
    if @producto.save
      redirect_to productos_url, notice: 'Producto creado con éxito.'
    else
      flash.now[:alert] = @producto.errors.full_messages.join(', ') 
      render :new
    end
  end
  
  def edit
    @producto = Producto.find(params[:id])
  end
  

  def update
    @producto = Producto.find(params[:id])
      # remover imagenes marcadas para eliminar
    if params[:producto][:imagenes_remove]
      params[:producto][:imagenes_remove].each do |imagen|
        @producto.imagenes.find { |img| img.identifier == imagen }.remove!
      end
    end
      #mantener las actuales
    if params[:producto][:imagenes]
      nuevas_imagenes = params[:producto][:imagenes]
      @producto.imagenes += nuevas_imagenes
    end
  
    if @producto.update(producto_params.except(:imagenes))
      redirect_to productos_url, notice: 'Producto actualizado con éxito.'
    else
      flash.now[:alert] = @producto.errors.full_messages.join(', ')
      render :edit
    end
  end
  


  def destroy
    @producto = Producto.find(params[:id])
    @producto.soft_delete
    redirect_to productos_path, notice: 'Producto eliminado con éxito.'
  end


  def edit_stock
    @producto = Producto.find(params[:id])
  end
    
  def update_stock
    @producto = Producto.find(params[:id])
    if stock_params[:stock].to_i < 1
      flash.now[:alert] = "El stock debe ser mayor o igual a 1"
      return render :edit_stock
    end
    if @producto.update(stock_params)
      redirect_to productos_url, notice: 'Stock actualizado con éxito.'
    else
      flash.now[:alert] = @producto.errors.full_messages.join(', ')
      render :edit_stock
    end
  
  end
  
  private
  
  def producto_params
    params.require(:producto).permit(:nombre, :descripcion, :precio, :categoria_id, { imagenes: [] }, :talle, :color_id, :fecha_ingreso, :fecha_modificacion, :fecha_baja)
  end

  def stock_params
    params.require(:producto).permit(:stock)
  end 

end
  
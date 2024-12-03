class VentasController < ApplicationController
  def index
    @ventas = Venta.where(active: true)
  end

  def new
    @venta = Venta.new
    @venta.ventas_productos.build
  end

  def create
    ActiveRecord::Base.transaction do
      if params[:venta][:cliente_id] == "new"
        @cliente = Cliente.create!(cliente_params)
        params[:venta][:cliente_id] = @cliente.id
      else
        # Eliminar los parámetros de cliente si no se está creando uno nuevo
        params[:venta].delete(:nombre)
        params[:venta].delete(:apellido)
        params[:venta].delete(:dni)
        params[:venta].delete(:telefono)
      end

      @venta = Venta.new(venta_params)
      if @venta.save
        @venta.ventas_productos.each do |vp|
          producto = vp.producto
          producto.update!(stock: producto.stock - vp.cantidad)
        end
        redirect_to ventas_path, notice: 'Venta registrada con éxito.'
      else
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render :new
  end

  def cancel
    puts("estoy en el controlador de cancelar venta ")
    @venta = Venta.find(params[:id])
    if @venta.active == false 
      redirect_to ventas_path , notice: 'La venta ya se encuentra cancelada'
    end
    ActiveRecord::Base.transaction do
      @venta.update!(active: false)
      @venta.ventas_productos.each do |vp|
        producto = vp.producto
        producto.update!(stock: producto.stock + vp.cantidad)
      end
    end
    redirect_to ventas_url, notice: 'Venta cancelada y stock revertido.'
  end

  private

  def venta_params
    params.require(:venta).permit(:fecha_hora, :total, :user_id, :cliente_id, ventas_productos_attributes: [:id, :producto_id, :cantidad, :precio_venta, :_destroy])
  end

  def cliente_params
    params.require(:venta).permit(:nombre, :apellido, :dni, :telefono)
  end

  
end

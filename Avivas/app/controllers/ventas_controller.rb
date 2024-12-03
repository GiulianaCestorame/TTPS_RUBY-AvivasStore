class VentasController < ApplicationController
  def index
    @ventas = Venta.where(active: true)
  end

  def new
    @venta = Venta.new
    @productos_con_stock = Producto.where('stock > 0') 
    @venta.ventas_productos.build
  end

  def create
    ActiveRecord::Base.transaction do
      # Verificar si el cliente es nuevo
      if params[:venta][:cliente_id].blank?
        @cliente = Cliente.create!(cliente_params)
        params[:venta][:cliente_id] = @cliente.id
        logger.info "Nuevo cliente creado: #{@cliente.inspect}"
      else
        # Eliminar los parámetros de cliente si no se está creando uno nuevo
        params[:venta].delete(:nombre)
        params[:venta].delete(:apellido)
        params[:venta].delete(:dni)
        params[:venta].delete(:telefono)
        logger.info "Cliente existente seleccionado: #{params[:venta][:cliente_id]}"
      end
  
      @venta = Venta.new(venta_params)
      #calcula total
      @venta.total = @venta.ventas_productos.sum { |vp| vp.cantidad * vp.precio_venta }
      logger.info "Total calculado: #{@venta.total}"
  
      if @venta.save
        # actualizar el stock de los productos vendidos
        @venta.ventas_productos.each do |vp|
          producto = vp.producto
          logger.info "Actualizando stock de producto: #{producto.nombre}, stock actual: #{producto.stock}"
          producto.update!(stock: producto.stock - vp.cantidad)
        end
        flash[:notice] = "Venta registrada con éxito."
        redirect_to ventas_path
      else
        logger.error "Errores al guardar la venta: #{@venta.errors.full_messages.join(', ')}"
        flash[:alert] = @venta.errors.full_messages.join(', ')
        raise ActiveRecord::Rollback # no se guarda nada si hay error
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render :new
  rescue => e
    flash.now[:alert] = "Error inesperado: #{e.message}"
    logger.error "Error al crear la venta: #{e.message}"
    logger.error e.backtrace.join("\n")
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
    params.require(:venta).permit(:cliente_id, :user_id, :fecha_hora, ventas_productos_attributes: [:producto_id, :cantidad, :precio_venta, :_destroy])
  end

  def cliente_params
    params.require(:venta).permit(:nombre, :apellido, :dni, :telefono)
  end



end

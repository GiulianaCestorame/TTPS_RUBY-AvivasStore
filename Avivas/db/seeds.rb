# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require_relative '../app/models/color'


gerente = User.find_or_create_by!(email: 'gerente@gerente.com') do |user|
  user.password = '123456'
  user.role_int = :manager
  user.username = "GerenteGeneral"
  user.phone = "123456789"
end

# Crear Empleado
empleado = User.find_or_create_by!(email: 'empleado@empleado.com') do |user|
  user.password = '123456'
  user.role_int = :employee
  user.username = "EmpleadoVentas"
  user.phone = "987654321"
end

# Crear Admin
admin = User.find_or_create_by!(email: 'admin@admin.com') do |user|
  user.password = '123456'
  user.role_int = :admin
  user.username = "Administrador"
  user.phone = "1122334455"
end

otro_usuario = User.find_or_create_by!(email: 'usuario@usuario.com') do |user|
  user.password = '123456'
  user.role_int = :employee
  user.username = "UsuarioRegular"
  user.phone = "3344556677"
end

empleado2 = User.find_or_create_by!(email: 'empleado2@empresa.com') do |user|
  user.password = '123456'
  user.role_int = :employee
  user.username = "EmpleadoSoporte"
  user.phone = "5566778899"
end

gerente2 = User.find_or_create_by!(email: 'gerente2@empresa.com') do |user|
  user.password = '123456'
  user.role_int = :manager
  user.username = "GerenteOperaciones"
  user.phone = "4455667788"
end


puts 'Usuarios creados con exitosamente.'

# Crear categorías
camisas = Categoria.find_or_create_by(nombre: 'Camisas')
pantalones = Categoria.find_or_create_by(nombre: 'Pantalones')
zapatos = Categoria.find_or_create_by(nombre: 'Zapatos')
accesorios = Categoria.find_or_create_by(nombre: 'Accesorios')

puts 'Categorías creadas exitosamente.'

azul = Color.find_or_create_by(nombre: 'Azul')
rojo = Color.find_or_create_by(nombre: 'Rojo')
negro = Color.find_or_create_by(nombre: 'Negro')


puts 'Colores creados exitosamente'

# Crear productos con colores y cargar imágenes
Producto.find_or_create_by(
  nombre: 'Camisa Azul',
  descripcion: 'Una camisa azul elegante para cualquier ocasión.',
  precio: 49.99,
  stock: 10,
  categoria: camisas,
  color: azul
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'camisaazul.jpg'))]
  prod.save
end

Producto.find_or_create_by(
  nombre: 'Zapatos Deportivos',
  descripcion: 'Zapatos deportivos ligeros y resistentes.',
  precio: 89.99,
  stock: 8,
  categoria: zapatos,
  color: negro
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'zapas.jpg'))]
  prod.save
end

Producto.find_or_create_by(
  nombre: 'Reloj de Pulsera',
  descripcion: 'Reloj de pulsera clásico con diseño minimalista.',
  precio: 199.99,
  stock: 5,
  categoria: accesorios
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'reloj.jpg'))]
  prod.save
end

Producto.find_or_create_by(
  nombre: 'Cinturón de Cuero',
  descripcion: 'Cinturón de cuero genuino con hebilla metálica.',
  precio: 39.99,
  stock: 20,
  categoria: accesorios
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'cinturon.jpg'))]
  prod.save
end

Producto.find_or_create_by(
  nombre: 'Zapatos Formales',
  descripcion: 'Zapatos formales de cuero para ocasiones especiales.',
  precio: 120.00,
  stock: 7,
  categoria: zapatos,
  color: negro
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'zapatos.jpg'))]
  prod.save
end

Producto.find_or_create_by(
  nombre: 'Camisa Blanca',
  descripcion: 'Camisa blanca clásica de manga larga.',
  precio: 45.00,
  stock: 12,
  categoria: camisas
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'camisa.jpg'))]
  prod.save
end

Producto.find_or_create_by(
  nombre: 'Pantalones Vaqueros',
  descripcion: 'Pantalones vaqueros de mezclilla azul de corte clásico.',
  precio: 65.00,
  stock: 18,
  categoria: pantalones,
  color: azul
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'OIP.jpg'))]
  prod.save
end

pantalon = Producto.find_or_create_by(
  nombre: 'Pantalones Negros',
  descripcion: 'Pantalones negros de vestir.',
  precio: 59.99,
  stock: 90,
  categoria: pantalones,
  color: negro
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'pexels-429124762-26256163.jpg'))]
  prod.save
end

zapatos = Producto.find_or_create_by(
  nombre: 'Zapatos mujer',
  descripcion: 'Zapatos stilettos rojos.',
  precio: 99.99,
  stock: 10,
  categoria: zapatos,
  color: rojo
) do |prod|
  prod.imagenes = [File.open(Rails.root.join('public', 'uploads', 'zapatosmujer.jpg'))]
  prod.save
end

puts 'Productos creados exitosamente.'



# Crear algunos clientes
cliente1 = Cliente.find_or_create_by(dni: '12345678') do |cliente|
  cliente.nombre = 'Juan'
  cliente.apellido = 'Pérez'
  cliente.telefono = '123456789'
end

cliente2 = Cliente.find_or_create_by(dni: '87654321') do |cliente|
  cliente.nombre = 'María'
  cliente.apellido = 'González'
  cliente.telefono = '987654321'
end

puts "Clientes creados exitosamente "



venta1 = Venta.find_or_create_by(fecha_hora: Time.now, user: gerente, cliente: cliente1, total: 199.98)
venta2 = Venta.find_or_create_by(fecha_hora: Time.now, user: empleado, cliente: cliente2, total: 59.99)

# Agregar productos vendidos a las ventas
VentasProducto.find_or_create_by(venta: venta1, producto: zapatos) do |vp|
  vp.cantidad = 2
  vp.precio_venta = 99.99
end

VentasProducto.find_or_create_by(venta: venta2, producto: pantalon) do |vp|
  vp.cantidad = 1
  vp.precio_venta = 59.99
end

puts "Ventas creadas exitosamente "






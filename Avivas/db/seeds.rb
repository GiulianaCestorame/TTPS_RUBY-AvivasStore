# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  email: 'gerente@gerente.com',
  password: '123456',
  role_int: :manager,
  username: "manager",
  phone: "123456"
)

User.create!(
  email: 'empleado@empleado.com',
  password: '123456',
  role_int: :employee,
  username: "empleado",
  phone: "123456"
)
User.create!(
  email: 'admin@admin.com',
  password: '123456',
  role_int: :admin,
  username: "admin",
  phone: "123456"
)


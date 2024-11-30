class HomeController < ApplicationController
  def index
    puts("se llamo a la funcion index del controlador home")
    @user = current_user
  end
end

class UsersController < ApplicationController
  before_action :authorize_admin, only: [:desactivar]
  before_action :authorize_admin_or_manager, only: [:index]

       
  def index
    puts("entre a la funcion de index ")
    @users = User.where.not(id: current_user.id)
    @current_user = current_user

  end

  def desactivar
    @user = User.find(params[:id])
    @user.delete!
    redirect_to users_path, notice: 'Usuario desactivado.'
  end

  private

  def authorize_admin
    unless current_user.admin?
    redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end

  def authorize_admin_or_manager
    unless current_user.admin? || current_user.manager?
      redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end




end
  



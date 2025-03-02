class UsersController < ApplicationController
  before_action :authorize_admin, only: [:desactivar]
  before_action :authorize_admin_or_manager, only: [:index, :edit_administracion, :update_administracion]

       
  def index
    @users = User.where.not(id: current_user.id)
    @current_user = current_user

  end

  def desactivar
    @user = User.find(params[:id])
    @user.delete!
    redirect_to users_path, notice: 'Usuario desactivado.'
  end

  def edit_administracion
    @user = User.find(params[:id])
    @current_user=current_user
  end

  def update_administracion
    @user = User.find(params[:id])
    # evitar que los gerentes cambien el rol de un usuario a admin
    if current_user.manager? && user_params[:role_int] == 'admin'
      flash.now[:alert] = 'No puedes asignar el rol de administrador a este usuario.'
      render :edit_administracion and return
    end
    if @user.update(user_params)
      redirect_to users_path, notice: 'Usuario actualizado con éxito.'
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ') 
      render :edit_administracion
    end
  end
  

  private

  def authorize_admin
    unless user_signed_in? && current_user.admin?
    redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end

  def authorize_admin_or_manager
    unless user_signed_in? && (current_user.admin? || current_user.manager?)
      redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone, :password, :role_int)
  end




end
  



# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_account_update_params, only: [:update]
   before_action :authenticate_user!
   before_action :authorize_admin_or_manager, only: [:new, :create]  # Esto asegurará que solo los administradores puedan crear usuarios
   skip_before_action :require_no_authentication, only: [:new, :create]


  #de perfil personal 
  def edit
    @user = current_user 
  end
  
#editar perfil personal 
#no se muestran los mensajes de error en el template 
  def update
    puts("entre a funcion del controlador")
    @user = current_user
    if @user.update_with_password(user_params)
      puts("act exitosa")
      redirect_to root_path, notice: 'Perfil actualizado con éxito.'
    else
      puts("no se pudo")
      render :edit
    end
  end


  def new 
    if user_signed_in? && (current_user.admin? || current_user.manager?) 
      @current_user=current_user
      @user = User.new 
    else 
      super 
    end
  end

  def create 
    if user_signed_in? && (current_user.admin? || current_user.manager?) 
      @user = User.new(user_params_create) 
      if @user.save 
        redirect_to users_path, notice: 'Usuario creado con éxito.' 
      else 
        flash.now[:alert] = @user.errors.full_messages.join(', ') 
        render :new 
      end 
    else 
      super 
    end 
  end


  def edit_administracion
    @user = User.find(params[:id])
  end

  def update_administracion
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'Usuario actualizado con éxito.'
    else
      render :edit
    end
  end

  private

#para que el gerente no pueda crear un user con rol admin, en caso de que seleccine admin(restringido por front) se asigna rol de empleado
  def user_params_create
    permitted_roles = current_user.admin? ? User.role_ints.keys : User.role_ints.keys.reject { |role| role == 'admin' }
    params.require(:user).permit(:username, :email, :phone, :role_int, :password, :password_confirmation).tap do |user_params|
      user_params[:role_int] = permitted_roles.include?(user_params[:role_int]) ? user_params[:role_int] : 'employee'
    end
  end
  

  def authorize_admin_or_manager
    unless current_user.admin? || current_user.manager?
      redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end

  def authorize_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
   end
  
   private


   #de editar perfil personal
  def user_params
    params.require(:user).permit(:username, :email, :phone, :password, :password_confirmation, :current_password)
  end


end

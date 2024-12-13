# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_account_update_params, only: [:update]
   before_action :authenticate_user!
   before_action :authorize_admin_or_manager, only: [:new, :create]
   skip_before_action :require_no_authentication, only: [:new, :create]


  #de perfil personal 
  def edit
    @user = current_user 
  end
  
#editar perfil personal 
  def update
    @user = current_user
    if @user.update_with_password(user_params)
      redirect_to root_path, notice: 'Perfil actualizado con éxito.'
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ') 
      render :edit
    end
  end

  def new 
    @current_user=current_user
    @user = User.new 
  end

  def create 
    @user = User.new(user_params_create) 
    if @user.save 
      redirect_to users_path, notice: 'Usuario creado con éxito.' 
    else 
      flash.now[:alert] = @user.errors.full_messages.join(', ') 
      render :new 
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
    unless user_signed_in? && (current_user.admin? || current_user.manager?)
      redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
    end
  end


  def user_params
    params.require(:user).permit(:username, :email, :phone, :password, :password_confirmation, :current_password)
  end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
   end
  



end

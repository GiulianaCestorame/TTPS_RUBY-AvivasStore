# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
   before_action :configure_account_update_params, only: [:update]

  def edit
    @user = current_user 
  end
  
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

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone, :role])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
   end
  
   private


  def user_params
    params.require(:user).permit(:username, :email, :phone, :password, :password_confirmation, :current_password)
  end


end

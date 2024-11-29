class UsersController < ApplicationController
    #before_action :authenticate_user!
    #before_action :authorize_admin_or_manager, only: [:index, :edit, :update, :destroy]
  
    def index
      @users = User.all
    end
  
  
    def desactivar
      @user = User.find(params[:id])
      @user.delete!
      redirect_to users_path, notice: 'Usuario desactivado.'
    end
  
    private
  
    def authorize_admin_or_manager
      unless current_user.admin? || current_user.manager?
        redirect_to root_path, alert: 'No tienes permisos para realizar esta acción.'
      end
    end


  
 
  end
  



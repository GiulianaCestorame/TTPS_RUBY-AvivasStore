class User < ApplicationRecord
  enum :role_int , admin: 0, manager: 1, employee: 2 
  before_create :set_joined_at
  before_update :restrict_role_change
  before_update :check_if_active_changed

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Formato de email incorrecto." }
  validates :phone, presence: true, format: { with: /\A\d{6,10}\z/, message: "El telefono debe tener entre 6 y 10 numeros" }
  validates :role_int, inclusion: { in: role_ints.keys.map { |role| role.to_s }, message: "%{value} Role invalido." }




  def delete!
    update(active: false, password: Devise.friendly_token[0, 20])
  end

  private

  def set_joined_at
    self.joined_at = Time.current unless joined_at
  end

  def check_if_active_changed
    if saved_change_to_active? && !active?
      # Ensure password is changed to a random token when deactivated
      self.password = Devise.friendly_token[0, 20] if active == false
    end
  end

  def restrict_role_change
    if role_int_changed?
      errors.add(:role_int, "cannot be changed.")
      throw :abort
    end
  end


end

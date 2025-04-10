class UsersBackoffice::ProfileController < UsersBackofficeController
  before_action :verify_password, only: [:update]
  before_action :set_user

  def edit
    @user.build_user_profile if @user.user_profile.blank?
  end

  def update
    if @user.update(params_user)
      sign_in(@user, bypass: true)
      redirect_to users_backoffice_profile_path, notice: "Usuário atualizado com sucesso!"
    else
      flash[:alert] = "Erro ao atualizar o perfil. Verifique os campos obrigatórios."
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def params_user
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation,
    user_profile_attributes: [:id, :address, :gender, :birthdate, :avatar])
  end

  def verify_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end
end

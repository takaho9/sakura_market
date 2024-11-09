class Users::UsersController < Users::ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path, notice: "郵送先が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :postal_code, :address)
  end
end

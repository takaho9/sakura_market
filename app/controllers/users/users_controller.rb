class Users::UsersController < Users::ApplicationController
  before_action :authenticate_user!

  def show
    @orders = current_user.orders.not_pending
  end

  def edit_address
  end

  def update_address
    if current_user.update(user_params)
      redirect_to session.delete(:return_to) || user_path, notice: "郵送先が更新されました。"
    else
      render :edit_address, status: :unprocessable_content
    end
  end
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :postal_code, :address)
  end
end

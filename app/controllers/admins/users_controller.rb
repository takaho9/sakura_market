class Admins::UsersController < Admins::ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]

  def index
    @users = User.default_order
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admins_user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @user.destroy
    redirect_to admins_users_path, notice: "ユーザーを削除しました。"
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :postal_code, :address)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

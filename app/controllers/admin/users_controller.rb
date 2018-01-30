class Admin::UsersController < AdminController
<<<<<<< 962826c0d70e28a96a43efddb47d65d180c6ab28
=======

>>>>>>> Admin - Manage Users
  before_action :load_user, only: [:show, :destroy]
  before_action :verify_admin, only: [:index, :show, :destroy]

  def index
    @users = User.order(created_at: :desc).page(params[:page]).per Settings.page.per_page
  end

  def show
    @orders_user = Order.orders_user(params[:id]).page(params[:page]).per Settings.page.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.user.success"
    else
      @messages = @user.errors
    end
    redirect_to admin_users_url
  end

  private
  def load_user
    return if @user = User.find_by(id: params[:id])
    flash[:danger] = t "admin.user.danger"
    redirect_to admin_users_url
  end
end

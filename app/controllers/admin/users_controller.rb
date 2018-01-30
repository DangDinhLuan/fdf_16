class Admin::UsersController < AdminController

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
      redirect_to admin_users_url
    else
      @messages = @user.errors
      redirect_to admin_users_url
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "admin.user.danger"
      redirect_to admin_users_url
    end
  end
end

class AdminController < ApplicationController
  include SessionsHelper
  layout "admin"
  before_action :verify_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @orders = Order.all.to_xls
    respond_to do |format|
      format.html
      format.xls {
        filename = "Order-#{Time.now.strftime("%Y%m%d%H%M%S")}.xls"
        send_data @orders,
          type: "text/xls; charset=utf-8; header=present",
          filename: filename
      }
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user? @user
  end

  def verify_admin
    if loged_in?
      unless current_user.admin?
        flash[:danger] = t "admin.danger"
        redirect_to root_url
      end
    else
      redirect_to login_path
    end
  end
end

class AdminController < ApplicationController
  include SessionsHelper
  layout "admin"
  include SessionsHelper

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

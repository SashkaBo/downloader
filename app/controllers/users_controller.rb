class UsersController < ApplicationController

  before_action :set_user, only: [:update, :destroy, :edit, :show]
  def index
    @users = User.all
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html { redirect_to new_user_registration_path }
      format.json { head :no_content }
    end
  end

  def create
    @user = User.new(user_params)
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @user, alert: "User wasn't updated." }
        format.json { head :no_content }
      end
    end
  end

  def destroy
    @user = User.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

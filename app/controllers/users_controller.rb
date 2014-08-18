class UsersController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource only: [:update, :destroy, :edit, :show]


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
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'User was deleted.' }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end

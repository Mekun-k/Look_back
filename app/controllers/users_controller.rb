class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
    @user.id = current_user.id
  end

  def update
    @user = User.find(params[:id])
    @user.id = current_user.id
    if @user.update(user_params)
      redirect_to edit_user_path(@user), success: t('defaults.message.user_info_updated')
    else
      flash.now['danger'] = t('defaults.message.not_user_info_updated')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:qiita_user_id, :default_task_cycle, :default_repeat_count)
  end
end
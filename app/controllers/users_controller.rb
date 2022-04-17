class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
    @user.id = current_user.id
    @notifications = @user.notification_at
    if @notifications.present?
      @notification = JSON.parse(@notifications)
      @notification_at_1 = @notification[0]
      @notification_at_2 = @notification[1]
      @notification_at_3 = @notification[2]
    end
  end

def update
    @user = User.find(params[:id])
    @user.id = current_user.id

    @notification_at_1 = params[:notification_at_1]
    @notification_at_2 = params[:notification_at_2]
    @notification_at_3 = params[:notification_at_3]
    @notification_all = "#{@notification_at_1},#{@notification_at_2},#{@notification_at_3}"
    @notification_at = @notification_all.split(',')

    if @user.update(user_params)
      @user.notification_at = @notification_at
      @user.save
      redirect_to edit_user_path(@user), success: t('defaults.message.user_info_updated')
    else
      flash.now['danger'] = t('defaults.message.not_user_info_updated')
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:qiita_user_id, :default_task_cycle, :default_repeat_count, :name)
  end
end
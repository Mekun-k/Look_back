class TasksController < ApplicationController
  before_action :authenticate_user!, except: %i[show, index]

  def index
    @tasks = Task.all.includes(:user).order(created_at: :desc)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, success: t('defaults.message.created', item: Task.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Task.model_name.human)
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task), success: t('defaults.message.updated', item: Task.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Task.model_name.human)
      render :edit
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    if @task.destroy
      redirect_to tasks_path, success: t('defaults.message.deleted', item: Task.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_deleted', item: Task.model_name.human)
      render :show
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :body, :task_url, :start_date, :doing_date, :task_state)
  end
end

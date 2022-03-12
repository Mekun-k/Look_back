class TasksController < ApplicationController
  before_action :authenticate_user!, except: %i[show, index]
  before_action :set_task, only: %i[ edit update destroy ]

  def index
    @tasks = Task.all.includes(:user).order(created_at: :desc)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @form = TaskForm.new
  end

  def create
    @form = TaskForm.new(task_params)
    @form.user_id = current_user.id

    if @form.valid?
      @form.save
      redirect_to tasks_path, success: t('defaults.message.created', item: Task.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Task.model_name.human)
      render :new
    end
  end

  def edit
    @form = TaskForm.new(task: @task)
  end

  def update
    @article = @task.article
    @form = TaskForm.new(task_params, task: @task, article: @article)
    @form.user_id = current_user.id

    if @form.valid?
      @form.save
      redirect_to @task, success: t('defaults.message.updated', item: Task.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Task.model_name.human)
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, success: t('defaults.message.deleted', item: Task.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_deleted', item: Task.model_name.human)
      render :show
    end
  end

  def today
    @tasks = Task.doing_today.includes(:user).order(created_at: :desc)
  end

  private

  def task_params
    params.require(:task).permit(:name, :body, :start_date, :doing_date, :task_state, :qiita_id)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end

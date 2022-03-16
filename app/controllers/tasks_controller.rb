class TasksController < ApplicationController
  before_action :authenticate_user!, except: %i[show, index]
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = Task.all.includes(:user).order(created_at: :desc)
  end

  def show
    @form = TaskForm.new(task: @task)
    @form.user_id = current_user.id
    @qiita_id = @form.qiita_id
    @choice = @form.choice
  end

  def new
    @form = TaskForm.new
    @start_date = Date.today
    @doing_date = Date.today
  end

  def create
    @form = TaskForm.new(task_params)
    @form.user_id = current_user.id

    if @form.valid?
      @form.save
      redirect_to tasks_path, success: t('defaults.message.created', item: Task.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Task.model_name.human)
      @start_date = Date.new(@form.start_date[1].to_i, @form.start_date[2].to_i, @form.start_date[3].to_i)
      @doing_date = Date.new(@form.doing_date[1].to_i, @form.doing_date[2].to_i, @form.doing_date[3].to_i)
      render :new
    end
  end

  def edit
    @form = TaskForm.new(task: @task)
    @start_date = @form.start_date
    @doing_date = @form.doing_date
    @qiita_id = @form.qiita_id
    @choice = @form.choice
  end

  def update
    @article = @task.article
    @form = TaskForm.new(task_params, task: @task, article: @article)
    @form.user_id = current_user.id
    if @form.valid?
      @form.save
      redirect_to @task, success: t('defaults.message.updated', item: Task.model_name.human)
    else
      @qiita_id = @form.qiita_id
      @choice = @form.choice
      @start_date = Date.new(@form.start_date[1].to_i, @form.start_date[2].to_i, @form.start_date[3].to_i)
      @doing_date = Date.new(@form.doing_date[1].to_i, @form.doing_date[2].to_i, @form.doing_date[3].to_i)
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
    params.require(:task).permit(:name, :body, :start_date, :doing_date, :task_state, :qiita_id, :choice)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end

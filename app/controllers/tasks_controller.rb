class TasksController < ApplicationController
  before_action :authenticate_user!, except: %i[show, index]
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_qiita_user_id, only: %i[ index show new edit today ]

  def index
    @tasks = Task.where(user_id: current_user.id).includes(:user).order("created_at DESC")

    @articles = Article.all.includes(:task).order(created_at: :desc)

    @qiita = @articles.map(&:qiita_id)
    @qiita_json = @qiita.to_json.html_safe
  end

  def show
    @form = TaskForm.new(task: @task)
    @form.user_id = current_user.id
    @qiita_id = @form.qiita_id
    @choice = @form.choice
  end

  def new
    @form = TaskForm.new
    @doing_date = Date.today
    @task_cycle = current_user.default_task_cycle
    @repeat_count = current_user.default_repeat_count
  end

  def create
    @form = TaskForm.new(task_params)
    @form.user_id = current_user.id

    if @form.valid?
      @form.save
      redirect_to tasks_path, success: t('defaults.message.created', item: Task.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Task.model_name.human)
      @doing_date = Date.new(@form.doing_date[1].to_i, @form.doing_date[2].to_i, @form.doing_date[3].to_i)
      render :new
    end
  end

  def edit
    @form = TaskForm.new(task: @task)
    @doing_date = @form.doing_date
    @qiita_id = @form.qiita_id
    @choice = @form.choice
    @task_cycle = @form.task_cycle
    @repeat_count = @form.repeat_count
  end

  def update
    @article = @task.article
    @reminder = @task.reminder
    @form = TaskForm.new(task_params, task: @task, article: @article, reminder: @reminder)
    @form.user_id = current_user.id
    if @form.valid?
      @form.save
      redirect_to @task, success: t('defaults.message.updated', item: Task.model_name.human)
    else
      @qiita_id = @form.qiita_id
      @choice = @form.choice
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
    @task = Task.where(user_id: current_user.id).includes(:user).order("created_at DESC")
    @tasks = @task.doing_today
    @articles = Article.all.includes(:task).order(created_at: :desc)

    @qiita = @articles.map(&:qiita_id)
    @qiita_json = @qiita.to_json.html_safe
  end

  def toggle
    id = params[:id] # // jsから受け取ったid
    @task = Task.find(id)
    @completed_flag = @task.completed_flag

    if @completed_flag
      @completed_flag = false
      @task.update(completed_flag: @completed_flag)
    else
      @completed_flag = true
      @task.update(completed_flag: @completed_flag)
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :body, :doing_date, :task_state, :qiita_id, :choice, :task_cycle, :repeat_count)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def set_qiita_user_id
    @qiita_user_id = current_user.qiita_user_id
  end
end

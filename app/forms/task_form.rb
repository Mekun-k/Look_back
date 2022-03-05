class TaskForm
  include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにしたいのでActiveModel::Modelをinclude
  include ActiveModel::Attributes

  attr_accessor :name, :body, :task_state, :doing_date, :start_date, :qiita_id, :user_id, :article_choice
  # バリデーション
  with_options presence: true do
    validates :name, length: { maximum: 30 }
    validates :body, length: { maximum: 50 }
    validates :task_state
    validates :start_date
    validates :doing_date
    validates :qiita_id
  end

  delegate :persisted?, to: :task

  def initialize(attributes = nil, task: Task.new)
    @task = task
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?
      fix_doing_date = Date.parse(@doing_date)
      fix_start_date = Date.parse(@start_date)
      @name.class
      binding.irb
      @task.save(
        user_id: user_id, name: name, body: body, task_state: task_state,
        doing_date: fix_doing_date, start_date: fix_start_date
      )
  end

  def to_model
    task
  end

  private

  attr_reader :task, :article

  def default_attributes
    {
      name: task.name,
      body: task.body,
      task_state: task.task_state,
      doing_date: task.doing_date,
      start_date: task.start_date,
      qiita_id: task.article&.qiita_id,
      # user_id: user.session[:user_id]
    }
  end
end
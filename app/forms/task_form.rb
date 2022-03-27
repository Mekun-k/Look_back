class TaskForm
  include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにしたいのでActiveModel::Modelをinclude
  include ActiveRecord::AttributeAssignment

  attr_accessor :name, :body, :task_state, :doing_date, :start_date, :qiita_id, :user_id, :task_id, :choice, :created_at
  # バリデーション
  with_options presence: true do
    validates :name, length: { maximum: 30 }
    validates :task_state
    validates :start_date
    validates :doing_date
    validates :qiita_id
    validates :choice
  end

  validates :body, length: { maximum: 100 }

  delegate :persisted?, to: :task

  def initialize(attributes = nil, task: Task.new, article: Article.new)
    @task = task
    @article = article
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?
      task.update(user_id: user_id, name: name, body: body, task_state: task_state, doing_date: doing_date, start_date: start_date)
      article.update(task_id: task.id, qiita_id: qiita_id, choice: choice)
  end

  def to_model
    task
  end

  private

  attr_reader :task, :article, :user

  def default_attributes
    {
      name: task.name,
      body: task.body,
      task_state: task.task_state,
      doing_date: task.doing_date,
      start_date: task.start_date,
      qiita_id: task.article&.qiita_id,
      task_id: task.article&.task_id,
      choice: task.article&.choice,
      created_at: task.created_at
    }
  end
end
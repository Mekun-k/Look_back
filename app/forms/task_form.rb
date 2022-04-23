class TaskForm
  include ActiveModel::Model # 通常のモデルのようにvalidationなどを使えるようにしたいのでActiveModel::Modelをinclude
  include ActiveRecord::AttributeAssignment

  attr_accessor :name, :body, :task_state, :doing_date, :qiita_id, :user_id, :task_id, :choice, :created_at, :task_cycle ,:repeat_count
  # バリデーション
  with_options presence: true do
    validates :name, length: { maximum: 30 }
    validates :task_state
    validates :doing_date
    validates :qiita_id
    validates :choice
    validates :task_cycle
    validates :repeat_count
  end

  validates :body, length: { maximum: 100 }

  delegate :persisted?, to: :task

  def initialize(attributes = nil, task: Task.new, article: Article.new, reminder: Reminder.new)
    @task = task
    @article = article
    @reminder = reminder
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?
      task.update(user_id: user_id, name: name, body: body, task_state: task_state, doing_date: doing_date)
      article.update(task_id: task.id, qiita_id: qiita_id, choice: choice)
      reminder.update(task_id: task.id, task_cycle: task_cycle, repeat_count: repeat_count)
  end

  def to_model
    task
  end

  private

  attr_reader :task, :article, :user, :reminder

  def default_attributes
    {
      name: task.name,
      body: task.body,
      task_state: task.task_state,
      doing_date: task.doing_date,
      qiita_id: task.article&.qiita_id,
      task_id: task.article&.task_id,
      choice: task.article&.choice,
      created_at: task.created_at,
      task_cycle: task.reminder&.task_cycle,
      repeat_count: task.reminder&.repeat_count
    }
  end
end
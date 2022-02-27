class TaskInfo
  include ActiveModel::Model
  attr_accessor :name, :body, :start_date, :doing_date, :task_state, :qiita_id

  validates :name, presence: true, length: { maximum: 30 }
  validates :body, length: { maximum: 50 }
  validates :task_state, presence: true
  validates :start_date, presence: true
  validates :doing_date, presence: true
  validates :qiita_id, presence: true

  def save
    # タスクの情報を保存し、「task」という変数に代入
    task = Task.create(name: name, body: body, task_state: task_state, start_date: start_date, doing_date: doing_date)
    # Qiitaの情報を保存
    Address.create(qiita_id: qiita_id)
  end
end





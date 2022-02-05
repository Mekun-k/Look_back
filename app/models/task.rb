class Task < ApplicationRecord
    belongs_to :user

    validates :name, presence: true, length: { maximum: 30 }
    validates :body, length: { maximum: 50 }
    validates :task_url, presence: true, length: { maximum: 100 }
    validates :task_state, presence: true
    validates :start_date, presence: true
    validates :doing_date, presence: true

    enum task_state: %i[waiting doing done]
    # 待機中、進行中、完了
end

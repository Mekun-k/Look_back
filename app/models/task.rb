class Task < ApplicationRecord
    belongs_to :user

    validates :name, presence: true, length: { maximum: 30 }
    validates :body, presence: true, length: { maximum: 50 }
    validates :task_url, presence: true, length: { maximum: 50 }
    validates :task_state, presence: true
    validates :start_date, presence: true
    validates :doing_date, presence: true


end

class Task < ApplicationRecord
    belongs_to :user
    has_one :article


    enum task_state: %i[waiting doing done]
    # 待機中、進行中、完了
    # 今日
    scope :doing_today, -> { where(doing_date: Time.current.all_day) }
end

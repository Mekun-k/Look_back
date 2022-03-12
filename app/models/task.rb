class Task < ApplicationRecord
    belongs_to :user
    has_one :article, dependent: :destroy

    enum task_state: %i[waiting doing done]
    # 待機中、進行中、完了

    scope :doing_today, -> { where(doing_date: Time.current.all_day) }
    # 今日
end

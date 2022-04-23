namespace :change_state do
  desc "Taskのstateを変更"
  task :update => :environment do
    Task.find_each do |task|
      if task.reminder.repeat_count == -1
        task.done! # タスクのステータスを「完了」に変更
      elsif task.doing_date == Date.today
        task.doing! # タスクのステータスを「進行中」に変更
      else
        task.waiting! # タスクのステータスを「待機中」に変更
      end
    end
  end
end



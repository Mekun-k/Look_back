 # 下記を追記　復習を行ったタスクの繰り返し周期を-1して保存する
 namespace :change_date do
  desc "Taskのcountを変更"
  task :update => :environment do
    Task.doing_today.find_each do |task|
      cycle = task.reminder.task_cycle # 繰り返し周期を取得
      result = task.doing_date.next_day(cycle) # 復習日＋繰り返し周期（数字）
      task.update!(doing_date: result)
    end
  end
 end

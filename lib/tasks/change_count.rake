 # 下記を追記　復習を行ったタスクの繰り返し周期を-1して保存する
 namespace :change_count do
  desc "Taskのcountを変更"
  task :update => :environment do
    Task.doing_today.find_each do |task|
      reminder = task.reminder
      count = reminder.repeat_count - 1
      reminder.update(repeat_count: count)
    end
  end
 end

# cronログを吐き出す場所
set :output, File.join(Whenever.path, "log", "cron.log")
# ジョブの実行環境の指定
set :environment, :development

# 1分毎にpush通知
every 1.minutes do
  begin
    rake "line_bot:push"
  rescue => e
    raise e
  end
end

every 1.days, at: '23:55 pm' do
  rake 'change_count:update'
  rake 'change_date:update'
end

every 1.days, at: '0:00 am' do
  rake 'change_state:update'
end

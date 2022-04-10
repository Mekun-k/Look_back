namespace :line_bot do
  desc 'LINEプッシュ通知を送ります'
  task :push => :environment do

    time = Time.current
    current_time = time.strftime('%H:%M')

    secret = ENV["LINE_CHANNEL_SECRET"]
    token = ENV["LINE_CHANNEL_TOKEN"]

    client = Line::Bot::Client.new { |config|
        config.channel_secret = secret
        config.channel_token = token
    }

    User.all.each{|u|

      uid = u.uid

      notification_at = u.notification_at
      notification = JSON.parse(notification_at)

      notification_1 = notification[0]
      notification_2 = notification[1]
      notification_3 = notification[2]

      if current_time == notification_1
        message = {
          type: 'text',
          text: '復習の時間です1'
        }
        response = client.push_message(ENV["LINE_UID"], message)
      end

      if current_time == notification_2
        message = {
          type: 'text',
          text: '復習の時間です2'
        }
        response = client.push_message(ENV["LINE_UID"], message)
      end

      if current_time == notification_3
        message = {
          type: 'text',
          text: '復習の時間です3'
        }
        response = client.push_message(ENV["LINE_UID"], message)
      end
    }
  end
end

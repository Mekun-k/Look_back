namespace :line_bot do
  desc 'hello worldします' # 説明文
  task :push do
    message = {
      type: 'text',
      text: '復習の時間です'
    }
    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    response = client.push_message(ENV["LINE_UID"], message)
    p response
  end
end

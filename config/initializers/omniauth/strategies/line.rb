require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Line < OmniAuth::Strategies::OAuth2
      # IDトークンからemailを取得するために'email'が必要
      # IDトークンからプロフィール画像を取得するのに'profile'が必要
      option :scope, 'openid email profile'

      option :client_options, {
        site:          'https://api.line.me',
        authorize_url: 'https://access.line.me/oauth2/v2.1/authorize',
        token_url:     '/oauth2/v2.1/token'
      }

      uid do
        raw_info['userId']
      end

      info do
        {
          name:        raw_info['displayName'],
          image:       raw_info['pictureUrl'],
          description: raw_info['statusMessage']
        }
      end

	  def raw_info
        @raw_info ||= verify_id_token
      end

      private

      # nonceをリクエストパラメータに追加するためoverride
      def authorize_params
        super.tap do |params|
          params[:nonce] = SecureRandom.uuid
          session["omniauth.nonce"] = params[:nonce]
          params[:prompt] = 'consent'
          session["omniauth.prompt"] = params[:prompt]
          params[:bot_prompt] = 'aggressive'
          session["omniauth.bot_prompt"] = params[:bot_prompt]
        end
      end

      # デフォルトだとクエリパラメータがついてエラーになるのでoverride
      def callback_url
        full_host + script_name + callback_path
      end

      def verify_id_token
        @id_token_payload ||= client.request(:post, 'https://api.line.me/oauth2/v2.1/verify',
          {
            body: {
              id_token:  access_token['id_token'],
              client_id: options.client_id,
              nonce:     session.delete("omniauth.nonce"),
              prompt:     session.delete("omniauth.prompt"),
              bot_prompt:     session.delete("omniauth.bot_prompt"),
            }
          }
        ).parsed

        @id_token_payload
      end
    end
  end
end
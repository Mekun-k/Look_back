class Api::QiitaController < ApplicationController
  # HTTPClientを呼び出す
  require 'httpclient'

  def index
    url = "https://qiita.com/api/v2/items"  # URLを設定
    client = HTTPClient.new                 # インスタンスを生成
    response = client.get(url)              # Getリクエスト
    render json: JSON.parse(response.body)  # 結果をjsonにパースして表示
  end
end
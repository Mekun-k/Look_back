class Api::QiitaController < ApplicationController
  # HTTPClientを呼び出す
  require 'httpclient'

  def index
    url = "https://qiita.com/api/v2/users/akaidonnbei/stocks"  # URLを設定 記事の一覧を作成日時の降順で返します。
    client = HTTPClient.new                 # インスタンスを生成
    response = client.get(url)              # Getリクエスト
    render json: JSON.parse(response.body)  # 結果をjsonにパースして表示
  end
endgit
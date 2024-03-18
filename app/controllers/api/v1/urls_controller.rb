class Api::V1::UrlsController < ApplicationController
  before_action do
    check_url
  end
  
  def create
    original = params[:url]
    digest = Digest::SHA256.hexdigest(original).first(7)

    # originalがparams[:url]のレコードがあれば、そのレコードのdigestを返す
    result = Url.find_or_create_by(original:, digest:)

    # ステータスコード200とdigestを含む短縮したURLをレスポンスで返す
    render json: { url: "http://localhost:3000/api/v1/urls/#{result.digest}" }, status: 201
  end

  # curl -XPOST "http://localhost:3000/api/v1/urls" -d '{"url": "https://www.google.co.jp/"}' -H 'Content-Type: application/json'

  private

  def check_url
    url = params[:url]
    if url.blank? || !valid_url(url)
      render json: {}, status: 400
      return
    end
  end

  def valid_url(url)
    url.start_with?("http://") || url.start_with?("https://")
  end
end

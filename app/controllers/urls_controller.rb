class UrlsController < ApplicationController
  def create
    check_url
    original = params[:url]
    digest = Digest::SHA256.hexdigest(original).first(7)

    # originalがparams[:url]のレコードがあれば、そのレコードのdigestを返す
    result = Url.find_or_create_by(original:, digest:)

    # ステータスコード200とdigestを含む短縮したURLをレスポンスで返す
    render json: { url: "http://localhost:3000/api/v1/urls/#{result.digest}" }, status: 201
  end

  # http://localhost:3000/:digest
  def jump
    url = Url.find_by(digest: params[:digest])&.original
    if url.nil?
      render json: {}, status: 404
    else
      redirect_to url, allow_other_host: true, status: 301
    end 
  end

  def index ; end

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

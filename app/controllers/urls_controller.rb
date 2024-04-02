class UrlsController < ApplicationController
  BASE_URL = "http://localhost:3000/".freeze
  ALLOWED_SCHEMES = %w[http https].freeze

  before_action :check_url, only: %i[create]
  before_action :set_url,   only: %i[jump]

  def create
    original = params[:url]
    digest = Digest::SHA256.hexdigest(original).first(Url::DIGEST_LENGTH)

    url = Url.find_or_create_by!(original:, digest:)

    # ステータスコード200とdigestを含む短縮したURLをレスポンスで返す
    render json: { url: BASE_URL + url.digest }, status: 201
  end

  def jump
    redirect_to @url, allow_other_host: true, status: 301
  end

  def index ; end

  private

  def check_url
    return if params[:url].present? && ALLOWED_SCHEMES.include?(URI.parse(params[:url]).scheme)
    raise ActionController::BadRequest.new("Invalid URL")
  end

  def set_url
    @url = Url.find_by!(digest: params[:digest]).original
  end
end

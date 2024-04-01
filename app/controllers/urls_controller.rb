class UrlsController < ApplicationController
  before_action only %i[create] do check_url  end
  before_action only %i[jump]   do check_path end

  def create
    original = params[:url]
    digest = Digest::SHA256.hexdigest(original).first(7)

    # originalがparams[:url]のレコードがあれば、そのレコードのdigestを返す
    result = Url.find_or_create_by(original:, digest:)

    # ステータスコード200とdigestを含む短縮したURLをレスポンスで返す
    render json: { url: "http://localhost:3000/#{result.digest}" }, status: 201
  end

  # http://localhost:3000/:digest
  def jump
    redirect_to @url, allow_other_host: true, status: 301
  end 

  # def jump
  #   url = Url.find_by(digest: params[:digest])&.original
  #   if url.nil?
  #     render json: {}, status: 404
  #   else
  #     redirect_to url, allow_other_host: true, status: 301
  #   end 
  # end

  def index ; end

  private

  def check_url
    return if params[:url].present? && (params[:url].start_with?("http://") || params[:url].start_with?("https://"))
    raise Exceptions::BadRequest
  end

  def check_path
    @url = Url.find_by(digest: params[:digest])&.original
    raise Exceptions::RecordNotFound if url.nil?
  end
end

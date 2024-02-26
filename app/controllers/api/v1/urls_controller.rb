class Api::V1::UrlsController < ApplicationController
  before_action do
    check_url
  end
  
  def create
    Url.create(original: "hoge", digest: "hoge")
  end

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

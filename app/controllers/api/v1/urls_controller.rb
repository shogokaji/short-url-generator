class Api::V1::UrlsController < ApplicationController
  def create
    Url.create(original: "hoge", digest: "hoge")
  end
end

require 'rails_helper'

RSpec.describe "Urls", type: :request do
  describe "POST /" do
    context 'urlが空のとき' do
      it 'ステータス400を返す' do
        post "/urls", params: { url: "" }

        expect(response).to have_http_status(400)
      end
    end
    context 'urlが不正の場合' do
      it 'ステータス400を返す' do
        post "/urls", params: { url: "htttp://localhost:3000" }

        expect(response).to have_http_status(400)
      end
    end
  end

  describe "POST /:digest" do
    before do
      Url.create(original: "htttp://localhost:3000", digest: "hoge")
    end

    context 'リクエストに成功したとき' do
      it 'ステータス301を返す' do
        get "/hoge"

        expect(response).to have_http_status(301)
      end
    end
    context '紐づくURLが存在しないとき' do
      it 'ステータス404を返す' do
        get "/huga"

        expect(response).to have_http_status(404)
      end
    end
  end
end

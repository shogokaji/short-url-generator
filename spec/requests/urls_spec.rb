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
end

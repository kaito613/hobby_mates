require 'rails_helper'

RSpec.describe "BoardFavorites", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/board_favorite/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/board_favorite/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end

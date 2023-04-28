require 'rails_helper'

RSpec.describe "Tops", type: :request do
  
  describe "home" do
    before do
      create(:board)
    end
    context "トップページにアクセスした場合" do
      it "リクエストが成功する" do
        get root_path
        expect(response).to have_http_status(:success)
      end
      it "変数に掲示板が全て降順で格納されているか" do
        get root_path
        boards = controller.instance_variable_get("@boards")
        expect(boards).to eq Board.all.order(created_at: :desc)
      end
    end
  end
end

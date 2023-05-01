require 'rails_helper'

RSpec.describe "Tops", type: :request do
  
  describe "home" do
    before do
      create_list(:board, 10)
    end
    context "トップページにアクセスした場合" do
      it "リクエストが成功する" do
        get root_path
        expect(response).to have_http_status(:success)
      end
      it "変数に掲示板が格納されているか" do
        # 5件が大切ではない、格納されていることが大切である。
        get root_path
        boards = controller.instance_variable_get("@boards")
        expect(boards).to eq Board.all.page(1).per(5).order(created_at: :desc)
      end
    end
  end
end

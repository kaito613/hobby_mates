require 'rails_helper'


RSpec.describe "Users", type: :request do
  #Deviseのテストヘルパーを有効にする
  include Devise::Test::IntegrationHelpers
  describe "show" do
    context "ユーザーがログインしている場合" do
      let(:user){create(:user)}
      let(:other_user){create(:user)}
      before {sign_in user}
      context "自分のページにアクセスした場合" do
        it "リクエストが成功する" do
          get "/users/#{user.id}"
          expect(response).to have_http_status(:success)
        end
        it "is_user_in_mypageにtrueが代入される" do
          get "/users/#{user.id}"
          #controllerから@is_user_in_mypageを参照している
          is_user_in_mypage = controller.instance_variable_get("@is_user_in_mypage")
          expect(is_user_in_mypage).to eq true
        end
      end

      context "他人のページにアクセスした場合" do
        it "リクエストが成功する" do
          get "/users/#{other_user.id}"
          expect(response).to have_http_status(:success)
        end
        it "is_user_in_mypageにfalseが代入される" do
          get "/users/#{other_user.id}"
          is_user_in_mypage = controller.instance_variable_get("@is_user_in_mypage")
          expect(is_user_in_mypage).to eq false
        end
      end
    end

    context "未登録ユーザーの場合" do
      # ログインはしていない
      let(:user){create(:user)}
      it "リクエストが成功する" do
        get "/users/#{user.id}"
        expect(response).to have_http_status(:success)
      end
      it "is_user_in_mypageにfalseが代入される" do
        get "/users/#{user.id}"
        is_user_in_mypage = controller.instance_variable_get("@is_user_in_mypage")
        expect(is_user_in_mypage).to eq false
      end
    end
  end
end
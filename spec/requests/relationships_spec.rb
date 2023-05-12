require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  include Devise::Test::IntegrationHelpers
  describe "create" do
    let!(:user){create(:user)}
    let!(:other_user){create(:user)}
    context "ユーザーがログインしている場合" do
      before{sign_in user}
      context "有効なリクエストが送られた場合" do
        it "レコードが作成される" do
          expect{post user_relationships_path(other_user)}.to change{Relationship.count}.by(1)
        end
      end
    end
    context "ユーザーがログインしていない場合" do
      it "ログインページに遷移される" do
        expect(post user_relationships_path(other_user)).to redirect_to user_session_path
      end
    end
  end
  describe "destroy" do
    let!(:user){create(:user)}
    let!(:other_user){create(:user)}
    let!(:relationship){create(:relationship, following: user, follower: other_user)}
    context "ユーザーがログインしている場合" do
      before{sign_in user}
      context "有効なリクエストが送られた場合" do
        it "レコードが削除される" do
          expect{delete user_relationship_path(other_user, relationship)}.to change{Relationship.count}.by(-1)
        end
      end
    end
    context "ユーザーがログインしていない場合" do
      it "ログインページに遷移される" do
        expect(delete user_relationship_path(other_user, relationship)).to redirect_to user_session_path
      end
    end
  end
end

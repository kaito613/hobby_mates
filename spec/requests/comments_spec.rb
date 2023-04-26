require 'rails_helper'

RSpec.describe "Comments", type: :request do
  include Devise::Test::IntegrationHelpers

  describe "create" do
    
    subject {post board_comments_path(board), params: {comment: {message: "hello", user_id: user.id}}}
    let(:board){create(:board)}
    let(:user){create(:user)}

    context "ユーザーがログインしている場合" do
      before{sign_in user}

      context "コメント投稿が成功した場合" do
        it "コメントのレコードが1増える" do
          expect {subject}.to change(Comment, :count).by(1)
        end
        it "掲示板の詳細画面に遷移する" do
          subject
          expect(response).to redirect_to(board_path(board))
        end
      end
    end
    context "ユーザーがログインしていない場合" do
      it "ログイン画面に遷移される" do
        subject
        expect(response).to redirect_to(user_session_path)
      end
    end
  end

  describe "new" do
  end

  describe "edit" do
    let(:user){create(:user)}
    let(:comment){create(:comment, user: user)}
    let(:other_user_comment){create(:comment)}
    context "ユーザーがログインしている場合" do
      before do
        sign_in user
      end
      it "編集画面へのリクエストが成功する" do
        get edit_comment_path(comment)
        
        expect(response).to have_http_status(:success)
      end
      context "存在しないコメントの編集画面にアクセスした場合" do
        it "新規投稿画面に遷移する" do
          get edit_comment_path(comment.id + 1)
          expect(response).to redirect_to(boards_path)
        end
      end
      context "他人のコメントの編集画面にアクセスした場合" do
        it "新規投稿画面に遷移する" do
          get edit_comment_path(other_user_comment)
          expect(response).to redirect_to(boards_path)
        end
      end
    end
    context "ユーザーがログインしていない場合" do
      it "ログイン画面に遷移する" do
        get edit_comment_path(comment)
        expect(response).to redirect_to(user_session_path)
      end
    end
  end

  describe "show" do
    let(:comment){create(:comment)}
    context "コメントの詳細画面にアクセスした場合" do
      it "リクエストが成功する" do
        get comment_path(comment)
        expect(response).to have_http_status(:success)
      end
    end
    context "存在しないコメントの詳細画面にアクセスした場合" do
      
      it "掲示板の一覧ページに遷移する" do
        get comment_path(comment.id + 1)
        expect(response).to redirect_to(boards_path)
      end
    end
  end

  describe "update" do
    let(:user){create(:user)}
    let(:board){create(:board)}
    let(:comment){create(:comment, user: user)}
    let(:other_user_comment){create(:comment)}
    # new_message = "new_message"
    let(:new_message) { 'new_message' }
    let(:valid_request) do
      patch comment_path(comment), params: {comment: {message: new_message}}
    end
    context "ユーザーがログインしている場合" do
      before{sign_in user}
      context "リクエストが成功した場合" do
        it "レコードの中身が書き換わる" do
          valid_request
          comment.reload
          expect(comment.message).to eq new_message
        end
      end
      context "他人のコメントにリクエストを送った場合" do
        it "レコードが書き換わらない" do
          patch comment_path(other_user_comment), params: {comment: {message: new_message}}
          comment.reload
          expect(comment.message).to_not eq new_message
        end
      end
    end
    context " ユーザーがログインしていない場合" do
      it "レコードの中身が書き換わらない" do
        valid_request
        comment.reload
        expect(comment.message).to_not eq new_message
      end
    end
    context "存在しないコメントのリクエストが送られた場合" do
      before{sign_in user}
      it "レコードが書き換わらない" do
        patch comment_path(comment.id + 1), params: {comment: {message: new_message}}
        comment.reload
        expect(comment.message).to_not eq new_message
      end
    end
  end

  describe "destroy" do
    let!(:user){create(:user)}
    let!(:comment){create(:comment, user: user)}
    let!(:other_user_comment){create(:comment)}
    context "ユーザーがログインしている場合" do
      before{sign_in user}
      context "リクエストが成功した場合" do
        it "レコードが1つ減る" do
          expect{delete comment_path(comment)}.to change{Comment.count}.by(-1)
        end
      end
      context "他人のコメントにリクエストを送られた場合" do
        it "レコードが削除されない" do
          expect{delete comment_path(other_user_comment)}.to change{Comment.count}.by(0)
        end
      end
    end
    context "ユーザーがログインしていない場合" do
      it "レコードが削除されない" do
        expect{delete comment_path(comment)}.to change{Comment.count}.by(0)
      end
    end
    context "存在しないコメントのリクエストが送られた場合" do
      it "レコードが削除されない" do
        expect{delete comment_path(comment.id + 1)}.to change{Comment.count}.by(0)
      end
    end
  end
end
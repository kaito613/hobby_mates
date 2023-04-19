require 'rails_helper'

RSpec.describe "Boards", type: :request do
  include Devise::Test::IntegrationHelpers
  RSpec::Matchers.define_negated_matcher :not_change, :change
  describe "new" do
  end

  describe "create" do
    # subjectは1回しか定義できない
    subject { post boards_path, params: { board: { title: "title", img: "", description: "" } } }

    context "ユーザーがログインしている場合" do
      let(:user){create(:user)}
      before{sign_in user}
      let(:board){build(:board, user: user)}

      context "新規投稿が成功した場合" do
        # it "掲示板が作成され保存される" do
        #  下記のコード新規投稿のボタンを押したと同じことをしている
        #  post boards_path, params: {board: {title: "title", img: "", description: ""}}
        #  テスト毎に削除されるので、レコードが1つあれば増えていることになる（元々は0）
        #  本来ならばpostした瞬間に増えることを確認したい
        #  expect(Board.count).to eq 1
        # end
        it "掲示板が作成され保存される" do
          expect { subject }.to change(Board, :count).by(1)
        end
        
        it "掲示板の詳細画面に遷移する" do
          subject
          # boardにテーブルないのレコードを代入している
          board = Board.last
          # board_pathに引数としてboardを渡している
          expect(response).to redirect_to(board_path(board))
        end
      end
    end
    context "ユーザーがログインしていない場合" do
      it "ログイン画面に遷移する" do
        subject
        expect(response).to redirect_to(user_session_path)
      end
    end
  end

  describe "index" do
    before do
      create(:board)
    end
    context "掲示板一覧ページにアクセスした場合" do
      it "リクエストが成功する" do
        get boards_path
        expect(response).to have_http_status(:success)
      end
      it "変数に掲示板が全て格納されているか" do
        get boards_path
        boards = controller.instance_variable_get("@boards")
        expect(boards).to eq Board.all.order(created_at: :desc)
      end
    end
  end

  describe "show" do
    let(:board){create(:board)}
    context "掲示板詳細画面にアクセスした場合" do
      it "リクエストが成功する" do
        get board_path(board)
        expect(response).to have_http_status(:success)
      end
    end
    context "存在しない掲示板の詳細画面にアクセスした場合" do
      it "掲示板一覧ページに遷移する" do
        get board_path(board.id + 1)
        expect(response).to redirect_to boards_path
      end
    end
  end

  describe "edit" do
    
    context "ユーザーがログインしている場合" do
      let(:user){create(:user)}
      let(:board){create(:board, user: user)}
      let(:other_user_board){create(:board)}

      before do
        sign_in user
      end

      it "編集ページへのリクエストが成功する" do
        get edit_board_path(board)
        expect(response).to have_http_status(:success)
      end
      context "存在しない掲示板にアクセスした場合" do
        it "新規投稿画面に遷移する" do
          get edit_board_path(board.id + 1)
          expect(response).to redirect_to new_board_path
        end
      end
      context "他人の掲示板にアクセスした場合" do
        it "新規投稿画面に遷移する" do
          get edit_board_path(other_user_board)
          expect(response).to redirect_to new_board_path
        end
      end
    end
    context "ユーザーがログインしていない場合" do
      let(:board){create(:board)}
      it "ログイン画面に遷移する" do
        get edit_board_path(board)
        expect(response).to redirect_to user_session_path
      end
    end
  end

  describe "update" do
    let(:user){create(:user)}
    let(:board){create(:board, user: user)}
    new_title = "new_title"
    let(:valid_request) do
      patch board_path(board), params: {board: {title: new_title}}
      end
    context "リクエストが成功した場合" do
      before{sign_in user}  
      it "レコードの中身が書き換わる" do
        valid_request
        board.reload
        expect(board.title).to eq "new_title"
      end
    end
    context "ログインしていないユーザーがリクエストを送った場合"do
      it "レコードが書き換わらない" do
        valid_request
        board.reload
        expect(board.title).to_not eq new_title
      end
    end
    context "存在しない掲示板のリクエストが送られた場合" do
      before{sign_in user}
      it "レコードが書き換わらない" do
        patch board_path(board.id + 1), params: {board: {title: new_title}}
        board.reload
        expect(board.title).to_not eq new_title
      end
    end
  end

  describe "destroy" do
    context "掲示板が削除された場合" do
      let(:user){create(:user)}
      before{sign_in user}
      # let!でitの前に変数が定義される。letのみだと呼び出された瞬間に作られる。
      let!(:board){create(:board, user: user)}
      it "Boardテーブルからレコードがひとつ減る" do
        # delete board_path(board)
        # expect(Board.count).to eq 0
        #let!ではなく、itの中にboardを定義しても良い
        expect{delete board_path(board)}.to change{Board.count}.by(-1)
      end
    end
    context "ログインしていないユーザーがリクエストを行った場合" do
      let!(:board){create(:board)}
      it "レコードが削除されない" do
        # 下記のコード実行前にboardのレコードが必要であるため、let!でitを
        # 実行した時点でboardを作成している。ただ単にboardを記述するだけでも
        # テストが通る。
        expect{delete board_path(board)}.to change{Board.count}.by(0)
      end
    end
    context "存在しない掲示板のリクエストが送られた場合" do
      let!(:board){create(:board)}
      it "レコードが削除されない" do
        expect{delete board_path(board.id + 1)}.to change{Board.count}.by(0)
      end
    end
  end
end



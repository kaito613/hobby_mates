require 'rails_helper'

RSpec.describe User, type: :model do
  let(:name) { "テスト太郎" }
  let(:email) { "test@example.com" }
  let(:password){ "password" }
  let(:user){ create(:user) }

  describe ".first" do

    subject {described_class.first}

    it "ユーザーが作成されている" do
      user
      expect(User.first).to eq user
    end
  end

  describe "validation" do

    describe "name" do
      context "空白の場合" do
        let(:user){build(:user, name: "")}
        it "保存されない" do
          expect(user).to_not be_valid
        end
        it "エラーメッセージが期待されているものである" do
          user.save
          expect(user.errors.full_messages).to match_array(["Name can't be blank"])
        end
      end
      context "名前が51文字以上の場合" do
        let(:user){build(:user, name: "a" * 51)}
        it "保存されない" do
          expect(user).to_not be_valid
        end
      end
    end

    describe "email" do
      context "空白の場合" do
        let(:user){build(:user, email: "")}
        it "保存されない" do
          expect(user).to_not be_valid
        end
        it "エラーメッセージが期待されているものである" do
          user.save
          expect(user.errors.full_messages).to match_array(["Email can't be blank"])
        end
      end
        it "有効ではないメールアドレスの場合" do
          invalid_emails = ["not_an_email", "noatsign.com", "missing@tld."]
          invalid_emails.each do |email|
            user = build(:user, email: email)
            expect(user).to_not be_valid
          end
        end

        it "有効なメールアドレスの場合" do
          valid_emails = ["valid@example.com", "another_valid.email@example.co.uk"]
          valid_emails.each do |email|
            user = build(:user, email: email)
            expect(user).to be_valid
          end
        end
    end

    describe "password" do
      context "空白の場合" do
        let(:user){build(:user, password: "")}
        it "保存されない" do
          expect(user).to_not be_valid
        end
        context "パスワードが有効ではない場合"
        it 'パスワードに英小文字が含まれない場合無効な状態であること' do
          user = User.new(password: '1'+'A' * 5, password_confirmation: '1A'+'a' * 3)
          user.valid?
          expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ1文字以上含む必要があります')
        end
      
        it 'パスワードに英大文字が含まれない場合無効な状態であること' do
          user = User.new(password: '1'+'a' * 5, password_confirmation: '1A'+'a' * 3)
          user.valid?
          expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ1文字以上含む必要があります')
        end
      
        it 'パスワードに数字が含まれない場合無効な状態であること' do
          user = User.new(password: 'A'+'a' * 5, password_confirmation: '1A'+'a' * 3)
          user.valid?
          expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ1文字以上含む必要があります')
        end
      
        it 'パスワードが5文字以下なら無効な状態であること' do
          user = User.new(password: '1A'+'a' * 3, password_confirmation: '1A'+'a' * 3)
          user.valid?
          expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ1文字以上含む必要があります')
        end
      
        it 'パスワードが13文字以上なら無効な状態であること' do
          user = User.new(password: '1A'+'a' * 11, password_confirmation: '1A'+'a' * 11)
          user.valid?
          expect(user.errors[:password]).to include('は半角6~12文字英大文字・小文字・数字それぞれ1文字以上含む必要があります')
        end
      
      end
    end
  end
end

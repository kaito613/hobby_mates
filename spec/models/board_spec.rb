require 'rails_helper'

RSpec.describe Board, type: :model do
  
  describe "validation" do

    context "全てのカラムが有効な場合" do
      let(:board){create(:board)}
      it "掲示板が作成される" do
        expect(board).to be_valid
      end
    end

    describe "title" do
      context "空白の場合" do
        let(:board){build(:board, title: "")}
        it "保存されない" do
          expect(board).to_not be_valid
        end
      end
    end
  end
end

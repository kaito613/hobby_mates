require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  describe "validation" do
    
    context "全てのカラムが有効な場合" do
      let(:comment){create(:comment)}
      it "コメントが作成される" do
        expect(comment).to be_valid
      end
    end

    describe "comment" do
      context "空白の場合" do
        let(:comment){build(:comment, message: "")}
        it "保存されない" do
          expect(comment).to_not be_valid
        end
      end
    end
  end
end

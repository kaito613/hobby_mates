require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "validation" do
    let!(:relationship){create(:relationship)}
    context "following_idとfollower_idが同じ組み合わせの場合" do
      it "レコードが作成されない" do
        same_relationship = build(:relationship, following: relationship.following, follower: relationship.follower)
        # expect(same_relationship).to_not be_valid
        expect(same_relationship.save).to eq false
      end
    end
  end
end

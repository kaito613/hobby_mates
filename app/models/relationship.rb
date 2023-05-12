class Relationship < ApplicationRecord
  # フォローするユーザーに結びついている
  belongs_to :following, class_name: "User"
  # フォローされるユーザーに結びついている
  belongs_to :follower, class_name: "User"

  # 相互関係にあるもの？同じ組み合わせは１つのレコードまでなので、どちらか片方をユニークにする必要がある。
  validates :following_id, presence: true  
  validates :follower_id, presence: true, uniqueness: { scope: :following_id }
  
end

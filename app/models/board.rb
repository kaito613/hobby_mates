class Board < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :board_favorites, dependent: :destroy

  validates :title, presence: true

  def is_favorited_by?(user)
    # selfにはboardが入る
    # board = Board.find(1)
    # board.is_favorited_by?(user)
    # すでに特定されているボードに対してメソッドを使用しているので自動的にselfにboardが格納される
    BoardFavorite.where(user_id: user.id, board_id: self.id).exists?
  end
end

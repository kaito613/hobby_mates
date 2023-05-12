class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :boards
  has_many :comments
  
  validates :name, presence: true, length: {maximum: 50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255},
                      format: {with: VALID_EMAIL_REGEX},
                      uniqueness: true, allow_blank: true
  
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
    validates :password, presence: true,
              format: { with: VALID_PASSWORD_REGEX,
              message: "は半角6~12文字英大文字・小文字・数字それぞれ1文字以上含む必要があります"}

  def current_user_in_mypage(params_user_id)
    self.id == params_user_id.to_i
  end

  # フォローする側から中間テーブルへのアソシエーション
  has_many :following_relationships, class_name: "Relationship", foreign_key: :following_id
  # フォローする側からフォローされたユーザーを取得する
  has_many :followings, through: :following_relationships, source: :follower

  # フォローされている側から中間テーブルへのアソシエーション
  has_many :followed_relationships, class_name: "Relationship", foreign_key: :follower_id
  # フォローされている側からフォローしている相手のユーザーを取得する
  has_many :followers, through: :followed_relationships, source: :following

  # あるユーザーが引数で渡されたuserにフォローされているか調べるメソッド
  def is_followed_by?(user)
    followed_relationships.find_by(following_id: user.id).present?
  end
end

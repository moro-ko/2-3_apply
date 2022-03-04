class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  
# アソシエーション
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定
  # has_many :xxx, class_name: "モデル名", foreign_key: "○○_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  # has_many :yyy, through: :xxx, source: :zzz
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
# バリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

# フォロー機能
# メソッドの記述:コントローラーをスッキリできる
  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
# 検索機能/検索方法分岐
  def self.looks(word, search)
    # 完全一致
    if search == "perfect_match"
      @user = User.where("name LIKE?", word )
    # 前方一致
    elsif search == "forward_match"
      @user = User.where("name LIKE?", word+'%' )
    # 後方一致
    elsif search == "backward_match"
      @user = User.where("name LIKE?", '%'+word )
    # 部分一致
    elsif search == "partial_match"
      @user = User.where("name LIKE?", '%'+word+'%' )
    else
      @user = User.all
    end
  end
      
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end

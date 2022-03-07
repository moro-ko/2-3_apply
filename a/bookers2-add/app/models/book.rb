class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  # 並び替え機能追加のため、以下のアソシエーションを追記
  # favoritesモデルを介してuserモデルのデータを持ってくるための記述
  has_many :favorited_users, through: :favorites, source: :user
  # has_many :week_favorites, -> { where(created_at: ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)) }, class_name: 'Favorite'
  has_many :book_comments, dependent: :destroy
  
  has_many :view_counts, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
# 検索方法分岐
  def self.looks(word, search)
    if search == "perfect_match"
      @book = Book.where("title LIKE?", word )
    elsif search == "forward_match"
      @book = Book.where("title LIKE?", word+'%' )
    elsif search == "backward_match"
      @book = Book.where("title LIKE?", '%'+word)
    elsif search == "partial_match"
      @book = Book.where("title LIKE?", '%'+word+'%')
    else
      @book = Book.all
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
end

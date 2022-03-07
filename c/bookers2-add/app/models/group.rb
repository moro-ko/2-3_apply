class Group < ApplicationRecord
    # アソシエーション
    has_many :user_groups, dependent: :destroy
    has_many :users, through: :user_groups

    # バリデーション
    validates :name, presence: true
    validates :introduction, presence: true
    
    has_one_attached :image
end

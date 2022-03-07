class Group < ApplicationRecord
    has_one_attached :image
    
    # アソシエーション
    has_many :user_groups, dependent: :destroy
    has_many :users, through: :user_groups

    # バリデーション
    validates :name, presence: true
    validates :introduction, presence: true
    
    def get_image
    (image.attached?) ? image : 'no_image.jpg'
    end

end

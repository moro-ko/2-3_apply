class BookComment < ApplicationRecord
    
    belongs_to :user
    belongs_to :book
    
    # check
    validates :comment, presence: true
end

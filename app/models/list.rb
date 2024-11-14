class List < ApplicationRecord
    # Associations
    has_many :bookmarks, dependent: :destroy
    has_many :movies, through: :bookmarks
    has_many :reviews, dependent: :destroy
    # Validation
    validates :name, presence: true, uniqueness: true
end

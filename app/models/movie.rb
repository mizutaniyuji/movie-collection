class Movie < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :introduction, presence: true, length: { maximum: 500 }
end

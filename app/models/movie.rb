class Movie < ApplicationRecord
  belongs_to :user
  mount_uploader :image_name, ImageNameUploader
  
  validates :title, presence: true, length: { maximum: 30 }
  validates :introduction, presence: true, length: { maximum: 500 }
  
  has_many :favorites, dependent: :destroy
  

end

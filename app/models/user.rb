class User < ApplicationRecord
    before_save { self.email.downcase! }
    mount_uploader :image_name, ImageNameUploader
    
    validates :name, presence: true, length: { maximum: 50 }
    validates :introduction, length: { maximum: 500 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    
    has_secure_password                  
    has_many :movies
    
    has_many :favorites, dependent: :destroy
    has_many :liketo, through: :favorites, source: :movie
    has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'movie_id'
    has_many :likefrom, through: :reverses_of_favorite, source: :user
    
  def like(other_movie)
      self.favorites.find_or_create_by(movie_id: other_movie.id)
  end

  def unlike(other_movie)
    favorite = self.favorites.find_by(movie_id: other_movie.id)
    favorite.destroy if favorite
  end

  def alreadylike?(other_movie)
    self.liketo.include?(other_movie)
  end
  
end

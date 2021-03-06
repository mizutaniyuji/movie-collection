class FavoritesController < ApplicationController
  
  def create
    movie = Movie.find(params[:movie_id])
    current_user.like(movie)
    flash[:success] = 'Movieをお気に入りに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    movie = Movie.find(params[:movie_id])
    current_user.unlike(movie)
    flash[:success] = 'Movieのお気に入り登録を解除しました。'
    redirect_back(fallback_location: root_path)
  end
end

class MoviesController < ApplicationController
  
  before_action :require_user_logged_in 
  before_action :correct_user, only: [:destroy, :edit, :update]

  def index
    @movies_romance = Movie.where(category: "Romance").order(id: :desc).page(params[:page]).per(25)
    @movies_horror = Movie.where(category: "Horror").order(id: :desc).page(params[:page]).per(25)
    @movies_comedy = Movie.where(category: "Comedy").order(id: :desc).page(params[:page]).per(25)
    @movies_sf = Movie.where(category: "SF").order(id: :desc).page(params[:page]).per(25)
    @movies_musical = Movie.where(category: "Msical").order(id: :desc).page(params[:page]).per(25)
    @movies_animation = Movie.where(category: "Animation").order(id: :desc).page(params[:page]).per(25)
  end
  
  def create
    @movie = current_user.movies.build(movie_params)
    @movie[:image_name] = "noimage.png" if params[:image_name].nil?
    
    if @movie.save
      flash[:success] = 'Movieを投稿しました。'
      redirect_to root_url
    else
      @movies = current_user.movies.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'Movieの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @movie = current_user.movies.find(params[:id])
    @movie.destroy
    flash[:success] = 'Movieを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def edit
    @movie = current_user.movies.find(params[:id])
  end

  def update
    @movie = current_user.movies.find_by(id: params[:id])
    
    if @movie.update(movie_params)
      flash[:success] = 'Movieは正常に更新されました'
      redirect_to @movie.user
    else
      flash.now[:danger] = 'Movieは更新されませんでした'
      render :edit
    end
    
  end
  
  private
  

  def movie_params
    params.require(:movie).permit(:introduction, :title, :category, :image_name)
  end
  
  def correct_user
    @movie = current_user.movies.find_by(id: params[:id])
    unless @movie
      redirect_to root_url
    end
  end
  
end

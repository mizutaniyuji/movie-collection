class ToppagesController < ApplicationController
  def index
    if logged_in?
      @movie = current_user.movies.build  # form_with 用
      @movies = current_user.movies.order(id: :desc).page(params[:page])
    end
  end
end

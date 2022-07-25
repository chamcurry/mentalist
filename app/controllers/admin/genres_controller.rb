class Admin::GenresController < ApplicationController
  def index
     @genre = Genre.new
     @genres = Genre.all

     search_soup = Genre.where("soup LIKE (?)","#{params[:soup]}").pluck(:id)
     @genre_searched = Genre.where("search_soup IN (?) ",search_soup)
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def update
  end

  def show
  end

  def destroy
  end
  private

  def genre_params
    params.require(:genre).permit(:soup,:noodle)
  end
end

class Admin::GenresController < ApplicationController
  def index
     @genre = Genre.new
     @genres = Genre.all
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

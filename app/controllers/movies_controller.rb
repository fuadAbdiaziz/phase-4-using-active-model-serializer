class MoviesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  def summary
    movie = Movie.find_by(id: params[:id])
    if(movie)
      render json: movie, serializer: MovieSummarySerializer, status: :ok
    else
      render json: {error: 'movie not found!'}, status: 404
    end
  end

  def summaries
    movies = Movie.all
    render json: movies, each_serializer: MovieSummarySerializer
  end
  

  private

  def render_not_found_response
    render json: { error: "Movie not found" }, status: :not_found
  end
end
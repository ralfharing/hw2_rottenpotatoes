class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def set_sort(sort)
    @sort_hilite = sort
    session[:sort] = sort
  end

  def set_ratings(ratings)
    @ratings = ratings
    @rating_keys = @ratings.keys
    session[:ratings] = @ratings
  end

  def index
    @all_ratings = Movie.all_ratings
    used_session = false

    if params[:sort]
      set_sort(params[:sort])
    elsif session[:sort]
      set_sort(session[:sort])
      used_session = true
    end

    if params[:ratings]
      set_ratings(params[:ratings])
    elsif session[:ratings]
      set_ratings(session[:ratings])
      used_session = true
    else
      return @movies = Movie.order(@sort_hilite).all
    end

    if used_session
      redirect_to movies_path({:sort => @sort_hilite, :ratings => @ratings})
    end

    @movies = Movie.order(@sort_hilite).where(:rating => @rating_keys)    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

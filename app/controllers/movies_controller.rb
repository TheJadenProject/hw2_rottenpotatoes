class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	@movie_highlight = ""
	@release_highlight = ""
	@sort = ""
	@all_ratings = Movie.all_ratings
	@ratings = {}

	if (params[:ratings] != nil)
		@ratings = params[:ratings]
		if (params[:sort] == "title")
			@movies = Movie.all_by_rating(params[:ratings].keys, "title")
		elsif (params[:sort] == "release") 
 			@movies = Movie.all_by_rating(params[:ratings].keys, "release_date")
		else
			@movies = Movie.all_by_rating(params[:ratings].keys, nil)		
		end
	else
		@all_ratings.each do |rating|
			@ratings[rating] = "1"
		end
		if (params[:sort] == "title")
			@movies = Movie.find(:all, :order => "title")
		elsif (params[:sort] == "release") 
	 		@movies = Movie.find(:all, :order => "release_date")
		else
			@movies = Movie.all
		end	
	end

    if (params[:sort] == "title")
		@movie_highlight = "hilite"
		@sort = "title"
    elsif (params[:sort] == "release") 
		@release_highlight = "hilite"
		@sort = "release"
	end 
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

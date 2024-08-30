class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:movie_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list), alert: 'Bookmark was successfully created.'
    else
      Rails.logger.debug "Bookmark errors: #{@bookmark.errors.full_messages.join(', ')}"
      render 'lists/show'
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end

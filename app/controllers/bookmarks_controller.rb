class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(review_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def review_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end

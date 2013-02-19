class FavoritesController < ApplicationController

  def create
    if current_user.favorite_gist(params[:gist_id])
      render nothing: true, status: 200
    else
      render nothing: true, status: 403
    end
  end

  def index
    @gists = current_user.favorite_gists
    respond_to do |format|
      format.json { render :json => @gists }
      format.html
    end
  end

  def destroy
    if current_user.unfavorite_gist(params[:gist_id])
      render nothing: true, status: 200
    else
      render nothing: true, status: 403
    end
  end

end

class GistsController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @gists = current_user.gists
  end

  def show
    @gist = Gist.find(params[:id])
  end

  def new
    @gist = Gist.new
    1.times { @gist.files.build }
  end

  def create
    @gist = current_user.gists.build(params[:gist])
    if @gist.save
      redirect_to @gist
    else
      flash[:error] = "Something went wrong. Please review your gist."
      render 'new'
    end
  end

  def show
    @gist = Gist.find(params[:id])
  end

  def destroy
    gist = Gist.find(params[:id]).destroy
    render :json => gist
  end
end

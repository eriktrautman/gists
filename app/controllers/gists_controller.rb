class GistsController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @gists = current_user.gists
  end

  def show
    @gist = Gist.find(params[:id])
  end

  def new
    gist = current_user.gists.create(title: "untitled gist")
    redirect_to edit_gist_path(gist)
  end

  def edit
    @gist = Gist.find(params[:id])
    1.times { @gist.files.build }
    flash[:success] = "Your gist has been created. Go ahead and edit it, and it'll
automatically be saved for you. Click done to go back to all your gists."
  end

  def update
    @gist = Gist.find(params[:id])
    @gist.assign_attributes(params[:gist])
    if @gist.save
      render nothing: true
    else
      flash[:error] = "Something went wrong with autosaving. Please review your gist."
      render :json => { message: "Fail" }
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

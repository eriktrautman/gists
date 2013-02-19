class TaggingsController < ApplicationController
  def create
    tag = Gist.find(params[:gist_id]).tag(params[:tag_name])
    if tag
      render json: tag
    else
      render json: { message: "Already tagged with #{params[:tag_name]}" }
    end
  end

  def destroy
    Tagging.where(gist_id: params[:gist_id], tag_id: params[:id]).first.destroy
    render nothing: true
  end

  def index
    @tags = Gist.find(params[:gist_id]).tags
    render :json => @tags
  end
end

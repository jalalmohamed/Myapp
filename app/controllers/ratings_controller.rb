class RatingsController < ApplicationController
  before_action :set_topic,only: %i[ new create ]
  before_action :set_rating, only: %i[ show edit update destroy ]
  before_action :set_post , only: %i[ new create ]
  def show

  end
  def new
    @rating=Rating.new
  end

  def create
    @rating=@post.ratings.create(rating_params)
    redirect_to topic_post_path(@topic,@post)
  end
  def destroy
    @rating.destroy
    redirect_to topic_post_path(@topic,@post)
  end

  private
  def set_topic
    @topic= Topic.find(params[:topic_id]) if params[:topic_id]
  end
  def set_post
    @post=Post.find(params[:post_id])
  end
  def set_rating
    @rating=@post.ratings.find(params[:id])
  end
  def rating_params
    params.require(:rating).permit(:num, :topic_id, :post_id, :id)
  end
end

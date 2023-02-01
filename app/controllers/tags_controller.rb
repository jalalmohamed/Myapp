class TagsController < ApplicationController
  before_action :set_post, only: %i[ new create ]
  before_action :set_tag, only: %i[ show edit update destroy ]
  before_action :set_topic, only: %i[ new create ]

  def index
    @tags=Tag.all
  end
  def show
  end
  def new
    @tag=Tag.new
  end
  def create
    @post.posttags.destroy_all
    @post.posttags.build(:tag_id=>@tag)
    @tag=@post.tags.build(tag_params)
    if @tag.save
      redirect_to topic_post_path(@topic,@post), notice: "Tag was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
  end
  def update
    if @tag.update(tag_params)
      redirect_to topic_post_path(@topic,@post), notice: "Tag was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @tag.destroy
    redirect_to tags_path, notice: "Tag was successfully deleted"
  end

  private
  def set_topic
    @topic=Topic.find(params[:topic_id])
  end
  def set_post
    @post=Post.find(params[:post_id])
  end
  def set_tag
    if params[:post_id]
      @tag=@post.tags.find(params[:id])
    else
      @tag=Tag.find(params[:id])
    end
  end
  def tag_params
    params.require(:tag).permit(:name, :topic_id, :post_id, :tag_id)
  end
end

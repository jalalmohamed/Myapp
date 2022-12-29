class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :set_topic, only: %i[ index new create ]
  def index
    @comments=@topic.comments
  end

  def show
  end#@comment = @post.topic.comments.build @topic.comments.build
  def new
    @comment =Comment.new
  end
  def create
      @comment = @post.comments.build(comment_params)
      if @comment.save
          redirect_to topic_post_path(@topic,@post), notice: "comment was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end
  def edit
  end
  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment was successfully deleted."
  end
  private
  def set_topic
   @topic= Topic.find(params[:topic_id])
  end

  def set_post
    @post= Post.find(params[:post_id])
  end
  def set_comment
    @comment=@post.comments.find(params[:id])
  end
  def comment_params #, :topic_id, :post_id
    params.require(:comment).permit(:commenter, :body)
  end
end

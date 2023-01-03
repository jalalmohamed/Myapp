class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if params[:topic_id]
      @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
    else
      # @posts = Post.all
      @posts = Post.paginate(page: params[:page], per_page: 6)
    end
  end
  # GET /posts/1 or /posts/1.json
  def show

  end

  # GET /posts/new
  def new
     @post = @topic.posts.build

  end
  # GET /posts/1/edit
  def edit

  end

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.build(post_params.except(:tags))
    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_post_path(@topic, @post), notice: "Post was successfully created." }
          #format.html { redirect_to post_path(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        if params[:topic_id]
          format.html { redirect_to topic_post_path([@topic, @post]), notice: "Post was successfully updated." }
        else
          format.html { redirect_to post_path(@post), notice: "Post was successfully updated." }
        end
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      if params[:topic_id]
        format.html { redirect_to topic_posts_path(@topic), notice: "Post was successfully destroyed." }
      else
        format.html { redirect_to posts_path, notice: "Post was successfully destroyed." }
      end
      format.json { head :no_content }
    end
  end

  private
    def set_topic
      @topic= Topic.find(params[:topic_id]) if params[:topic_id]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      if params[:topic_id]
        @post = @topic.posts.find(params[:id])
      else
        @post = Post.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
        params.require(:post).permit(:name, :publish, :image, :topic_id, :post_id, tags_attributes: [:name],tag_ids: [])
    end
end

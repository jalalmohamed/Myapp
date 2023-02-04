class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :disable_bullet_if_index
  protect_from_forgery except: [:index ,:show, :create, :new]
  before_action :authenticate_user!
  before_action :set_topic
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if params[:topic_id]
      @posts=@topic.posts.paginate(page: params[:page], per_page: 10).includes([:users])
      # @post = @topic.posts.build
    else
      @start_date= params[:start_date]? Date.parse(params[:start_date]) : Date.yesterday
      @end_date= params[:end_date]? Date.parse(params[:end_date]) : Date.today
      @posts = Post.includes(:topic, :users).date_between(@start_date,@end_date).paginate(page: params[:page], per_page: 6)
    end
  end
  # GET /posts/1 or /posts/1.json
  def show
    @post=@topic.posts.includes(comments: [:user]).find(params[:id])
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
    @post = @topic.posts.build(post_params)
    @post.user_id=current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_post_path(@topic, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to topic_post_path([@topic, @post]), notice: "Post was successfully updated." }
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

  def read
    @post.users << current_user unless @post.users.include?(current_user)
    head :created
  end
  private
    def disable_bullet_if_index
      return unless defined? Bullet
      Bullet.enable = false if params[:action] == "index"
    end
    def set_topic
      @topic= Topic.find(params[:topic_id]) if params[:topic_id]
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = @topic.posts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
        params.require(:post).permit(:name, :publish, :image, :topic_id, :post_id, tags_attributes: [:name],tag_ids: [])
    end
end

class PostsController < ApplicationController
  before_action :set_topic
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_select_collections, only: [:edit, :update, :new, :create, :show]
  # GET /posts or /posts.json
  def index
    if params[:topic_id]
      @posts = @topic.posts.paginate(page: params[:page], per_page: 6)
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
     @all_tags=Tag.all
     @posttag=@post.posttags.build
  end
  # GET /posts/1/edit
  def edit
    @posttag=@post.posttags.build
  end

  # POST /posts or /posts.json
  def create
    @post = @topic.posts.build(post_params.except(:tags))
    create_or_delete_posts_tags(@post, params[:post][:tags])
    #@post = Post.new(post_params)
    params[:tags][:id].each do |tag|
          if !tag.empty?
            @post.posttags.build(:tag_id => tag)
          end
        end
    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_posts_path([@topic, @post]), notice: "Post was successfully created." }
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
    create_or_delete_posts_tags(@post, params[:post][:tags])
    #@post.posttags.destroy_all
    params[:tags][:id].each do |tag|
      if !tag.empty?
        @post.posttags.build(:tag_id=>tag)
      end
    end
    #@post.posttags.build(:tag_id=>@tag)
    #@post.tags << Tag.find_or_create_by(name: @tag)
    respond_to do |format|
      if @post.update(post_params)
        if params[:topic_id]
          format.html { redirect_to topic_posts_path([@topic, @post]), notice: "Post was successfully updated." }
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
      format.html { redirect_to topic_posts_path(@topic,:posts), notice: "Post was successfully destroyed." }
      else
        format.html { redirect_to posts_path, notice: "Post was successfully destroyed." }
      end
      format.json { head :no_content }
    end
  end

  private
  def set_select_collections
    @all_tags=Tag.all
  end
  def create_or_delete_posts_tags(post,tags)
    post.posttags.destroy_all
    tags=tags.strip.split(',')
    tags.each do |tag|
      post.tags << Tag.find_or_create_by(name: tag)
    end
  end
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
      if params[:topic_id]
        params.require(:post).permit(:name, :publish, :topic_id)
      else
        params.require(:post).permit(:name, :publish)
      end
    end
end

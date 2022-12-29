class InsidesController < ApplicationController
  before_action :set_article
  before_action :set_inside, only: %i[ show edit update destroy ]

  def index
    @insides=@article.insides
    #@insides=inside.all
  end

  def new
    @inside=@article.insides.build
    #@inside=inside.new
  end

  def show
  end

  def create
    @inside = @article.insides.build(inside_params)
    if @inside.save
      flash[:notice]= "Inside was successfully created."
      redirect_to [@article, @inside]
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit

  end
  def update
    if @inside.update(inside_params)
      redirect_to [@article, @inside], notice: "Inside was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  def destroy
    @inside.destroy
    redirect_to [@article, :insides], notice: "Inside was successfully destroyed."
  end
  private
  def set_article
    @article = Article.find(params[:article_id])
  end
  def set_inside
    @inside=@article.insides.find(params[:id])
  end

  def inside_params
    params.require(:inside).permit(:commenter, :body, :article_id)
  end
end

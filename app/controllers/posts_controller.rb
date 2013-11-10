class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    # @post = Post.find(params[:id]) in before action now
    # @comment = Comment.new
    @comment = @post.comments.new
    @post.comments.reload # why?
  end

  def new
    @post = Post.new
    # do i need a category instance var?
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = 1 # default user as Waine

    if @post.save
      flash[:notice] = 'Your post was created'
      redirect_to posts_path
    else # validation error
      render :new
    end
  end

  def edit
    # @post = Post.find(params[:id]) in before action now
    # do i need a category instance var?
    @categories = Category.all
  end

  def update
    # @post = Post.find(params[:id]) in before action now

    if @post.update(post_params)
      flash[:notice] = 'The post was updated'
      redirect_to posts_path
    else
      render :edit
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # params.require(:post).permit(:title, :url)
    params.require(:post).permit!
  end
end

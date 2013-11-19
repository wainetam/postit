class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_login, except: [:index, :show]
  before_action :require_login_by_id, only: [:edit]
  before_action :one_vote_per_user, only: [:vote]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
    # @comment = @post.comments.new
    # @post.comments.reload # why?
  end

  def new
    @categories = Category.all
    @post = Post.new
  end

  def create
    @categories = Category.all
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]

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
    # debugger
    @categories = Category.all
    # @post = Post.find(params[:id])

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

  def vote
    # @post.votes << Vote.create(vote: params[:vote], user_id: session[:user_id])
    @vote = Vote.create(voteable: @post, vote: params[:vote], user_id: session[:user_id])
    
    if @vote.valid?
      flash[:notice] = "Your vote was counted" 
    else 
      flash[:error] = "Your vote was not counted. Something went wrong" 
    end
    redirect_to :back
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # params.require(:post).permit(:title, :url)
    params.require(:post).permit!
  end

  def require_login_by_id
    unless logged_in_as_creator?(@post)
      flash[:error] = "You need to login as the content creator to complete that action"
      redirect_to login_path
    end
  end      

  def one_vote_per_user
    vote_array = @post.votes
    vote_array.each do |vote_obj|
      if session[:user_id] == vote_obj.user_id  
        vote_obj.errors.add(:vote, "User can't vote more than once to same content")
        flash[:error] = "You already voted!"
        redirect_to :back and return
      end  
    end
  end

end

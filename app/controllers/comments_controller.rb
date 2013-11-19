class CommentsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_comment, only: [:vote]
  before_action only: [:vote] do 
    one_vote_per_user(@comment)
  end
  
  def create
    @post = Post.find(params[:post_id]) # find function takes an id
    @comment = @post.comments.new(comment_params)
    @comment.user_id = session[:user_id] # default user as Waine
    
    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post) #posts/:id
    else
      @post.comments.reload # why?
      render 'posts/show'
    end
  end

  def vote
    @vote = Vote.create(voteable: @comment, vote: params[:vote], user_id: session[:user_id], voteable_id: params[:id])
    
    if @vote.valid?
      flash[:notice] = "Your vote was counted" 
    else 
      flash[:error] = "Your vote was not counted. Something went wrong" 
    end
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # def one_vote_per_user
  #   vote_array = @comment.votes
  #   vote_array.each do |vote_obj|
  #     if session[:user_id] == vote_obj.user_id  
  #       vote_obj.errors.add(:vote, "User can't vote more than once to same content")
  #       flash[:error] = "You already voted!"
  #       redirect_to :back and return
  #     end  
  #   end
  # end

end

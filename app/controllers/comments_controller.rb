class CommentsController < ApplicationController

  def create
    # @post = Post.find(params[:id])
    # debugger
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

  private

  def comment_params
    params.require(:comment).permit!
  end
end

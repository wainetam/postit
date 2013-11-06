class CommentsController < ApplicationController
  # def new
  #   @comment = Comment.new
  # end

  def create
    # @post = Post.find(params[:id])
    @post = Post.find(params[:post_id])
    # @comment = Comment.new
    # @comment = Comment.find(comment_params)
    @comment = @post.comments.create(comment_params)

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post) #posts/:id
    else
      # debugger
      render 'posts/show' 
      # render posts_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end
end

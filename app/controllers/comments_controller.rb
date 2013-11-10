class CommentsController < ApplicationController
  # def new
  #   @comment = Comment.new
  # end

  def create
    # @post = Post.find(params[:id])
    # debugger
    @post = Post.find(params[:post_id]) # find function takes an id
    @comment = @post.comments.create(comment_params)

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post) #posts/:id
    else
      # debugger
      render 'posts/show' 
      # render post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end
end

class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_menber.posts.new(comment_params)
    comment.post_id = post_id.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
  end

  private
  def commnet_params
    params.require(:comment).permit(:post_comment)
  end
end

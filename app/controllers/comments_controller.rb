class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_menber.comments.new(comment_params)
    comment.post_id = post.id
   if comment.save
    redirect_to post_path(post)
   else
    redirect_to post_path(post),notice: "コメントが書かれていません。"
   end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:post_comment)
  end
end

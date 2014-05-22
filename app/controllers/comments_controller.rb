class CommentsController < ApplicationController
  def create
  	@post = Post.find(params[:post_id])
  	@user= User.find(current_user.id)
    item_params=params.require(:comment).permit(:user_id,:post_id,:text)
  	item_params[:user_id]=current_user.id
    @comment=@post.comments.build(item_params)
    @comment.save
    @comment=@user.comments.build(item_params)  
    @comment.save

  	redirect_to @post

  end

  def destroy
  	@comment=Comment.find(params[:id])
    if @comment.user_id == current_user.id
         comment_id(@comment.id)
    @comment.destroy  
    end
  	
	redirect_to @comment.post

  end
end

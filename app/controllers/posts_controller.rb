class PostsController < ApplicationController
  before_action :logged_in_user
  def index
    @newpost = current_user.posts.build
    @posts = Post.all
  end
  def create

    @new_post = current_user.posts.build(params.require(:post).permit(:content))
    @new_post.save
    redirect_to posts_path
  end
end

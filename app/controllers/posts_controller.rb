class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  def index
    @posts = Post.includes(:user).order(created_at: :desc)  # fetch all posts with user info
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)  # fill from the form
    @post.user = current_user      # tie the post to whoever is logged in

    if @post.save
      redirect_to posts_path, notice: "Post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end

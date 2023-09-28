class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, except: [:new, :create, :index]
  before_action :build_post, only: [:create]
  before_action :check_post_ownership, only: [:create, :update, :destroy]
  before_action -> { verify_object_viewable(@post) }, only: [:show]

  def index
    @posts = timeline_posts.page params[:page]
    @comment = current_user.comments.build
    @post = current_user.posts.build
  end

  def timeline_posts
    Post.with_attached_image.includes([:image_attachment, :likes, :likers, user: [:profile], comments: [:likes, :likers]])
        .where(user_id: [current_user.id, current_user.friends.map(&:id)].flatten)
        .order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    success_message = "Post was successfully created"
    if @post.save
      respond_to do |format|
        format.turbo_stream { flash.now[:success] = success_message }
        format.html {
          redirect_to posts_path
          flash[:success] = success_message
        }
      end
    else
      redirect_to posts_path
      flash[:warning] = 'Failed to create post. Please try again.'
    end
  end

  def update
    success_message = "Post was successfully updated"
    if @post.update(post_params)
      respond_to do |format|
        format.turbo_stream { flash.now[:success] = success_message }
        format.html { 
          redirect_to posts_path
          flash[:success] = success_message
        }
      end
    else
      render :edit
      flash[:warning] = "Failed to update post"
    end
  end

  def destroy
    success_message = 'Post successfully removed.'

    if @post.destroy
      respond_to do |format|
        format.turbo_stream { flash.now[:info] = success_message }
        format.html {
          redirect_to posts_path
          flash[:success] = success_message
        }
      end
    else
      redirect_to posts_path
      flash[:warning] = "Failed to remove post."
    end
  end

  def show
    @comment = Comment.new
  end

  def edit; end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def build_post
    @post = current_user.posts.build(post_params)
  end

  def check_post_ownership
    user_id = @post.user_id
    redirect_to root_url, alert: 'Not allowed!' unless user_id == current_user.id
  end
end

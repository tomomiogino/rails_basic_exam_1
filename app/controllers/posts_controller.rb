class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @post.save
        redirect_to posts_path, notice: "新規投稿が完了しました！"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
    if @post.user == current_user
      render :edit
    else
      redirect_to post_path, notice: "権限がありません"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿済内容を編集しました！"
    else
      render :edit
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました！"
    # else
    #   redirect_to post_path, notice: "権限がありません"
    end
    # @post.destroy
    # redirect_to posts_path, notice: "投稿を削除しました！"
  end

  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    render :new if @post.invalid?
  end

  private
  def post_params
    params.require(:post).permit(:content, :image, :image_cache, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

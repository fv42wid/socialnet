class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :share]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.last(5).reverse
    @post = params[:post] || Post.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.body = params[:body]
    @post.user_id = current_user.id
    @post.mentions
    @post.mentioned_users
    @post.notify_mentioned_users
    respond_to do |format|
      if @post.save
        current_user.events.create(action: "posted", eventable: @post)
        format.html { redirect_to events_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to posts_path, flash: {errors: @post.errors} }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def share 
    current_user.events.create(action: "shared", eventable: @post)
    redirect_to events_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.fetch(:post, {})
    end
end

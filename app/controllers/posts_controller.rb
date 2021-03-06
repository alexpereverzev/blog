class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :exception
 # include SessionHelper

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    if signed_in?
    @post = Post.new
    else
      @posts = Post.all
      render 'index'
  end

  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    if signed_in?
    
    @post = Post.new(post_params)
    @user= User.find(current_user.id)
    @post=@user.posts.build(post_params)  
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.user_id == current_user.id
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
    else
      render action: 'edit' 
  end

  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
     if signed_in?
     if @post.user_id == current_user.id
      #@post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url
      if @post.user_id == current_user.id
      @post.destroy
        end
       }
      format.json { head :no_content }
      format.js {render :layout => false}
                end
      end
    else
      
      respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
     # format.js {render :layout => false}
    end
    
  end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text)
    end
end

class PostsController < ApplicationController
    
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    # find the blog for the id provided
@blog = Blog.find(params[:blog_id])
# Get all the posts associated with this blog
@posts = @blog.posts 
  end



  # GET /posts/new
 # GET /blogs/1/posts/new
def new
  @blog = Blog.find(params[:blog_id])
  # Associate an post object with the blog
  @post = @blog.posts.build
end

  # GET /posts/1/edit
def edit
@blog = Blog.find(params[:blog_id])
@post = @blog.posts.find(params[:id])
end
  # POST /posts
  # POST /posts.json
 # POST /blogs/1/posts
def create
@blog = Blog.find(params[:blog_id])
@post =
@blog.posts.build(posts_params)
if @post.save
# Post saved, redirect to blog page
redirect_to blog_post_url(@blog, @post)
else
render :action => "new"
end
end
# GET /blogs/1/posts/2
def show
@blog = Blog.find(params[:blog_id])
# Find an post in blogs 1 that has id=2
@post = @blog.posts.find(params[:id])
end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
def update
@blog = Blog.find(params[:blog_id])
@post = Post.find(params[:id])
if
@post.update_attributes(posts_params)
# Post saved, redirect
redirect_to blog_post_url(@blog, @post)
else
render :action =>"edit"
end
end

# DELETE /blogs/1/posts/2
def destroy
 @blog = Blog.find(params[:blog_id])
 @post = Post.find(params[:id])
 @post.destroy
 respond_to do |format|
 format.html {redirect_to blog_posts_path(@blog) }
 format.xml { head :ok }
 end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:post_message, :blog_id)
    end
    
    def posts_params
params.require(:post).permit(:post_message)
    end
end

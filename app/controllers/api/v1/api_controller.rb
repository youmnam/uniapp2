class Api::V1::ApiController < ApplicationController


skip_before_action :verify_authenticity_token
	#get all cateogries listed registerd at the system
def authenticate
  user = UserApp.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
          render json: user.to_json
       else
          render json: user 
      end
  end


def listUsers
  @users  = UserApp.all
  render json: @users 
end


def addPost

  @post = Post.new(post_params)
  if @post.save
    render json: @post.to_json , status: :created
  else 
    render json: @post.errors
  end 

end


def listPosts
  
 
   @post  = Post.select(" posts.*, user_apps.name, user_apps.ppic
    , (select count(comments.id) from comments where posts.id = comments.post_id group by comments.post_id)").joins(",user_apps where user_apps.id = posts.user_app_id")   
   
  render json: @post.to_json 
end


def listPostswithLike
  
 if( params[:usrid] != nil)
   @post  = Post.select(" posts.*, user_apps.name, user_apps.ppic
    , (select count(comments.id) from comments where posts.id = comments.post_id group by comments.post_id), 
    (select count(postlikes.id) from postlikes where postlikes.user_app_id = "+params[:usrid]+"  and posts.id = postlikes.post_id ) as like").joins(",user_apps where user_apps.id = posts.user_app_id")   
else
@post  = Post.select(" posts.*, user_apps.name, user_apps.ppic
    , (select count(comments.id) from comments where posts.id = comments.post_id group by comments.post_id)").joins(",user_apps where user_apps.id = posts.user_app_id")   
   
end    

  render json: @post.to_json 
end

def getPost

  @post = Post.find(params[:id])
  render json: @post
end

def addComment 

   @comment = Comment.new(comment_params)
  if @comment.save
    render json: @comment.to_json , status: :created
  else 
    render json: @comment.errors
  end 

end


def like

    @post = Post.find(params[:post_id])
    if(@post.numberOfLikes == nil)
        @post.update(:numberOfLikes => 1)
    else
       @post.update(:numberOfLikes => (@post.numberOfLikes+1))
    end
    Postlike.create(:user_app_id => params[:user_app_id]  , :post_id => params[:post_id] )
  

   render json: @post
  

end


def unlike
  @post = Post.find_by(:id => params[:post_id])
  @post.update(:numberOfLikes => (@post.numberOfLikes-1))
  userid = params[:user_app_id].to_s
  postid = params[:post_id].to_s
  query = "user_app_id = "+ userid +" AND  post_id = " + postid
  puts query
  @postlike= Postlike.where( query)

  @postlike.destroy_all
  
  render json: @post
end


def listComments

@comments = Comment.select("comments.*, user_apps.name").joins(",user_apps").where(" user_apps.id = comments.user_app_id AND comments.post_id =" + params[:id])   

   render json: @comments
end

#given 
#postid  , 0/1
def isLikedAllPosts
    @posts = Postlike.where("user_app_id =" + params[:id] )

 render json: @posts

end


private 

def post_params
      params.require(:post).permit(:title, :content, :numberOfLikes , :user_app_id)
    end
def comment_params
      params.require(:comment).permit(:content, :user_app_id , :post_id)
    end

end

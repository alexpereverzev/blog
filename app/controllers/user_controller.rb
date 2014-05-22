class UserController < ApplicationController

  
  def login
 
  	 end

  def create
  		item_param=params.require(:user).permit(:name, :password, :image)
  		@user=User.new(item_param)
  		#if @user.save
        #@user.save
  			sign_in @user
          redirect_to :controller => 'posts',:action => 'index'
     # else
      #  render 'login'
  		#end
 	 end
end

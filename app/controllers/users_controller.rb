# = CONTROLADOR USUARIOS
class UsersController < ApplicationController
	#before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  	#before_action :correct_user,   only: [:edit, :update]
  	#before_action :admin_user,     only: :destroy

	#Metodo mostrar usuario
	def show
  		@user = User.find(params[:id])
  		@title = @user.name
		@microposts = @user.microposts.paginate(page: params[:page])
  	end

	def index
  		@buscar = params[:nombre];

                if @buscar
                        @users = User.where(name: @buscar).paginate(page: params[:page]) 
                else
                        @users = User.paginate(page: params[:page])
                end
	end

  	def new
		@user = User.new
  	end

	#Metodo registrar usuario
	def create
    		@user = User.new(user_params)
    		if @user.save
    			sign_in @user
			flash[:success] = "Bienvenido a la red social Empleate!"
			redirect_to @user
		else
      			render 'new'
    		end
  	end
	
	def edit
   		 @user = User.find(params[:id])
  	end

	def update
    		@user = User.find(params[:id])
    		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
      			redirect_to @user
    		else
      		  render 'edit'
    		end
  	end

	def destroy
    		User.find(params[:id]).destroy
    		flash[:success] = "User deleted."
    		redirect_to users_url
  	end

	def following
    		@title = "Following"
    		@user = User.find(params[:id])
    		@users = @user.followed_users.paginate(page: params[:page])
    		render 'show_follow'
  	end

  	def followers
    		@title = "Followers"
    		@user = User.find(params[:id])
    		@users = @user.followers.paginate(page: params[:page])
    		render 'show_follow'
  	end	

  	private

    	def user_params
      		params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    	end

	def signed_in_user
      		redirect_to signin_url, notice: "Please sign in." unless signed_in?
    	end

	def correct_user
      		@user = User.find(params[:id])
      		redirect_to(root_url) unless current_user?(@user)
    	end

    	def admin_user
      		redirect_to(root_url) unless current_user.admin?
    	end
	
end




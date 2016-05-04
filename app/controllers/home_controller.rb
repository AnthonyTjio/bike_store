class HomeController < ApplicationController

  before_action :set_user, only: [:update]

  def index
  end

  def signup
  	@user = User.new
  	@type =["User", "Admin"]
  end

  def login
  	@user = User.new
  end

  def logout
  	# routes & view required
  		session[:user_id] = nil
  		redirect_to home_login_path
  end

  def authentication
  	# routes & view required
  	
  	@user = User.authenticate(params[:username], params[:password])

  	if(@user) # if user found
  		session[:user_id] = @user.id
  		redirect_to home_index_path
  	else # if user not found
  		redirect_to request.referer, :notice => "User not found!"
  	end
  end

  def create
  	@user = User.new(user_params)
  	if(@user.save)
  		redirect_to request.referer, :notice => "New user created!"
  	else
  		redirect_to request.referer, :notice => "Cannot create new user"
  	end
  end

  def test
  	
  end

  private
  	def set_user
  		@user = User.find(params[:id])
  	end

  	def user_params
  		params.require(:user).permit(:username, :password, :confirm_password, :type)
  	end

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  helper_method :current_user

  private
  	def current_user
      current_uri = request.env['PATH_INFO']

  		if(session[:user_id]) 
  			@current_user = @current_user || User.find(session[:user_id])
        flash.now[:notice] = @current_user.username
        #buffer = 
        #flash.now[:notice] = 
  		else
        #if current_uri != home_login_path
        #  redirect_to home_login_path, :notice  => "Please Login First"        
        #end
      end
  	end

end

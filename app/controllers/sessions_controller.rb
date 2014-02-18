class SessionsController < ApplicationController
	
	def new
	end
	
	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			#iceri al
			sign_in(user)
			flash[:info] = "Welcome..." << user.name
			redirect_to user
		else
			# flash.now specific for render
			# flash is for redirect
			flash.now[:error] = "We Could not find you..."
			render "new"
		end
	end
	
	def destroy
		remember_token = User.encrypt(session[:remember_token])
		user = User.find_by(remember_token: remember_token)
		sign_out(user)
		redirect_to root_path
	end

end

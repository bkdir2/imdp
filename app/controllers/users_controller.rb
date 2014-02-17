class UsersController < ApplicationController
  
  def index
		@users = User.all
  end


  def new
		@user = User.new
  end


  def create
  	@user = User.new(accessible_params)
		if @user.save
			flash[:info] = "Successfully Registered"
			redirect_to @user
		else
			flash[:error] = "Could not Registered"
			render "new"
		end
  end


  def edit
  	@user = User.find(params[:id])
  end


	#dogrulugundan emin degilim update method.
  def update
  	@user = User.find(params[:id])
		if @user.update_attributes(accessible_params)
			flash[:info] = "Updated"
			redirect_to @user
		else
			flash[:error] = "Could not Updated"
			render "edit"
		end
  end


  def show
		@user = User.find(params[:id])
  end
  
end


private

def accessible_params
	params.require(:user).permit(:name, :email, :age, :password,
		:password_confirmation)
end
class UsersController < ApplicationController

	# kullanicilarin bu actionlardan bazilarini yapabilmeleri
	# icin signed_in olmus olmalari lazim. 
	# bunu kontrol etmek icin action dan once diyosun:
	before_action :signed_in_user, only: [:edit, :update, :index]

	# bazi actionlar icinse sign in yetmez, yetkisi olmasi lazim
	# mesela john, marry nin profil bilgilerini editleyemez
	before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.all
  end

  def show
		@user = User.find(params[:id])
  end

  def new
		@user = User.new
  end

  def create
  	@user = User.new(accessible_params)
		if @user.save
			sign_in(@user)
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
  
  private

	# guvenlik icin disardan erisilebilecek parametreler
	# bu fonksiyon ile sinirlandiriliyor.
	def accessible_params
		params.require(:user)
		.permit(:name, 
						:email, 
						:age, 
						:password,
						:password_confirmation)
	end

	#Before Filters:

	# kullanici bir action a gitmek istediginde signed_in olmusmu
	# diye buraya gelicez, eger olmamissa signin sayfasina redirect 
	# edicez ama oncesinde kullanici nereye gitmek istemis? onu tutuyoruz.
	def signed_in_user
		store_location
		redirect_to signin_url, notice: "Please Sign in" if !signed_in?
	end

	# signin oldum, infomu update edicem. eyw. ama eger baskasinin infosunu
	# editlemeye calisirsam, ben "correct_user" miyim diye bir bakar bu metod.
	def correct_user
		@user = User.find(params[:id])
		redirect_to root_url if @user != current_user
	end

end
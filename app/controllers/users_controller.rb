class UsersController < ApplicationController

	# kullanicilarin bu actionlardan bazilarini yapabilmeleri
	# icin signed_in olmus olmalari lazim. 
	# bunu kontrol etmek icin action dan once diyosun:
	before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
	before_action :admin_user, only: :destroy
	before_action :new_user_only, only: [:new, :create]

	# bazi actionlar icinse sign in yetmez, yetkisi olmasi lazim
	# mesela john, marry nin profil bilgilerini editleyemez
	before_action :correct_user, only: [:edit, :update]

  def index
		@users = User.paginate(page: params[:page])
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

  def destroy
  	user = User.find(params[:id])
  	# adminin kendini silmesini engellemek amacli ama dogrumu oldu
		# bir daha kontrol et
		# .admin? metodu admin boolean oldugu icin kendiliginden geliyor.
  	if !user.admin? && user != current_user
			user.destroy
  	end
  	
  	flash[:info] = "User deleted"
  	redirect_to users_url
  end
  
  private

	# guvenlik icin disardan erisilebilecek parametreler
	# bu fonksiyon ile sinirlandiriliyor.
	# admin bu listede yok. Eger koyarsak biri Patch ile admin=1
	# gonderip hackleyebilir.
	def accessible_params
		params.require(:user)
		.permit(:name, 
						:email, 
						:age, 
						:password,
						:password_confirmation)
	end

	# Before Filters:

	# kullanici bir action a gitmek istediginde signed_in olmusmu
	# diye buraya gelicez, eger olmamissa signin sayfasina redirect 
	# edicez ama oncesinde kullanici nereye gitmek istemis? onu tutuyoruz.
	def signed_in_user
		if !signed_in?
			intended_location
			redirect_to signin_url, notice: "Please Sign in"
		end
	end

	# signin oldum, infomu update edicem. eyw. ama eger baskasinin infosunu
	# editlemeye calisirsam, ben "correct_user" miyim diye bir bakar bu metod.
	def correct_user
		@user = User.find(params[:id])
		redirect_to root_url if @user != current_user
	end
	
	# admin olmayan biri silemye kalkarsa diye garantiye almak icin
	def admin_user
		redirect_to root_path unless current_user.admin?
	end

	# new ve create gibi actionlar sadece henuz uye/login olmamis olanlar
	# icin
	def new_user_only
		redirect_to root_path if signed_in?
	end

end
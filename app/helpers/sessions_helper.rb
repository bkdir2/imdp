module SessionsHelper

	# .permanent 20 yil sonra siliniyor
	# tek attribute oldugu zaman virgulle.
	# self kafa karistirici ama amaci belli
	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token 
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end
	
	# session i bitirmeden once DB de remember_token i yeniliyoruz
	# guvenlik icin daha sonra once cookiyi temizliyoruz sonra da 
	# current_user i
	def sign_out(user)
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	
	# Bu sekilde yazilmis bir fonksiyona ( function_name = (obj) seklinde)
	# sign_in fonksiyonunda yazdigimiz gibi "self.current_user = user"
	# seklinde assignment yapmamiz mumkun.
	def current_user=(user)
		@current_user = user
	end
	
	# yukaridaki "current_user=(user)" fonksiyonu sen redirect ile baska sayfaya
	# gittikten sonra ise yaramaz. @current_user "nil" olur.
	# bu kodun ise yaramasi icin bir adet "current_user" fonksiyonu yazip
	# remember_ token kullanarak gidip db den bulmamiz gerek.
	# remember_token i DB de encryptli sekilde tuttugumuz anca cookies de
	# encrypt yapmadan tuttugumuz icin once bir encrypt yapicaz.
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end
		
	# oncelikli amaci "view" larda gozuken linkler
	# user in signed_in olup olmamasina bagli olarak degisecegi icin
	# bu fonk. kullanilarak belirlenmesi.
	# islemler variable uzerinde yapilmiyor current_user bir fonksiyon aslinda.
	def signed_in?
		!current_user.nil?
	end

	# login olmamis userlarin gitmek istedigi page i hafizada tut
	# login olurlarsa sabit bir sayfaya gondermektense "intended"
	# sayfalarina yonlendireceksin.
	def intended_location
		session[:return_to] = request.url if request.get?
	end

	def redirect_to_intended_location(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

end

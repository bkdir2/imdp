module UsersHelper
	#Returns the gravatar image of given user
	def gravatar_for(user, options = { size: 30})
		# gravatar MD5 kullanarak emailini hash ediyor.
		# o yuzden MD5 kullanip, emaili de downcase yaparak
		# verilen emaile gore fotoyu cekicez
		# downcase yapmamizin sebebi biz emailleri case
		# insensitive tutuyoruz, gravatar tutmuyor.
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
	# Returns the Gravatar (http://gravatar.com/) for the given user.
end

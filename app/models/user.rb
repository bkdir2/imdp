class User < ActiveRecord::Base
	before_save {self.email.downcase!}

	validates :name, presence: true, length: {maximum: 50}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, presence:true, format: {with: VALID_EMAIL_REGEX },
					  uniqueness: {case_sensitive: false}
	
	# Presence validations for the password and its confirmation 
	# are automatically added by has_secure_password.
	validates :password, length: {minimum: 6}					  

	# adding password an password_confirmation attributes,
	# requiring the presence of the password, requiring that 
	# they matched,
	# authenticate method to compare the pw with password_digest
	# are made by "has_secure_password"
	# as long as there is a password_digest column in the database
	has_secure_password				  
end

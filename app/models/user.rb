class User < ActiveRecord::Base
	attr_accessor :name, :email
	
	def self.inspect
		"User name is: #{@name} E-mail address: <#{@email}>"
	end

end

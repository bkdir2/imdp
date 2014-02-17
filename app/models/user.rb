class User < ActiveRecord::Base
	#attr_accessible :name, :email

=begin
def initialize (attributes = {})

		@name = attributes[:name]
		@email = attributes[:email]
end
=end

	
	def self.inspect
		"User name is: #{@name} E-mail address: <#{@email}>"
	end

end

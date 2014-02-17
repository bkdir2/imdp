class User < ActiveRecord::Base

	def index
		@users = User.all
	end
end

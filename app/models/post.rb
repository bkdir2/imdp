class Post < ActiveRecord::Base

	#postun olmasi icin user_id nin olmasi sart.
	validates :user_id, presence: true
	belongs_to :user
	validates :content, presence: true, length: {maximum: 3500}

	default_scope -> { order('created_at DESC') }

#comment to test git history post.rb

end

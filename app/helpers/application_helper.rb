module ApplicationHelper

	# to set the given titles of the application
	# if it is not given, set the default title 
	def set_title(page_title)
		default_title = "Movie Discussion Platform"
		if page_title.empty?
			default_title
		else
			"#{default_title} | #{page_title}"
		end
	end
	
end

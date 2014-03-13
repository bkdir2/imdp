namespace :db do
	
	desc "Fill Database"
	task populate: :environment do
		User.create!(
			name: "Example User",
			email: "example@hede.com",
			password: "foobar",
			password_confirmation: "foobar")
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password  = "password"
			User.create!(
				name: name,
        email: email,
        password: password,
        password_confirmation: password)
		end 
	end
	
	desc "Create Posts for each user"
	task createposts: :environment do
		users = User.all(limit: 6)
		i = 1
		15.times do
			title = "Title for Example Posts - #{i}"
			content = Faker::Lorem.paragraphs(2).to_s
			users.each { |user| user.posts.create!(title: title, content: content) }
			i = i + 1
		end
	end
end
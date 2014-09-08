require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/connection'
require_relative './lib/category'
require_relative './lib/comment'
require_relative './lib/post'
require_relative './lib/subscriber'

after do
  ActiveRecord::Base.connection.close
end

get("/") do
  redirect "/posts"
end

get("/posts") do
  erb(:index, { locals: { posts: Post.all.order(created_at: :desc), comments: Comment.all(), categories: Category.all(), never_date: Date.new(2999, 1, 1)  } })
end

get("/posts/:id") do
	post = Post.find_by( id: params[:id] )
  	
  erb(:"posts/post", { locals: { posts: Post.all.order(created_at: :desc), post: post, comments: Comment.all(), categories: Category.all()  } })
end

post("/posts/:id/comment") do
	post = Post.find_by( id: params[:id] )
	comment_hash = {
		content: params["content"],
		post_id: post[:id]
	}

	Comment.create(comment_hash)

	redirect "/posts/#{params[:id]}"
end

get("/new/post") do
	erb(:"posts/post_new", { locals: { posts: Post.all.order(created_at: :desc), comments: Comment.all(), categories: Category.all()  } })
end

post("/new/post") do

	case params["expiration"]
	when "never"						# 29990101
		post_expiration = Date.new 2999, 1, 1 
	when "one_month"
		post_expiration = Date.today >> 1
	when "three_months"
		post_expiration = Date.today >> 3
	when "one_year"
		post_expiration = Date.today >> 12
	end

	post_hash = {
		category_id: params["category_id"],
		subject: params["subject"],
		content: params["content"],
		expiration: post_expiration
	}
	Post.create(post_hash)

	redirect "/posts"
end

get("/categories/:id/posts") do
	erb(:"categories/category", { locals: { posts: Post.all.order(created_at: :desc), comments: Comment.all(), category: Category.find_by_id(params[:id])  } })
end

get("/category_search") do 
	redirect "/categories/#{params[:id]}/posts"
end 

get("/new/category") do
	erb(:"categories/category_new", { locals: { posts: Post.all.order(created_at: :desc), comments: Comment.all(), categories: Category.all()  } })
end

post("/new/category") do
	category_hash = {
		name: params["name"],
		description: params["description"]
	}

# create on condition that it doesn't already exist
	categories = Category.all
	if 
		categories.any? {|x| x[:name] == params["name"]}
		# alert "That category already exists"
	#	message = "That category already exists."
	else
		Category.create(category_hash)
	end

	erb(:"categories/category_new", { locals: { posts: Post.all.order(created_at: :desc), comments: Comment.all(), categories: Category.all()  } })
end

# delete("/categories/:id") do 
# 	category = Category.find_by( {id: params[:id]} )
# 	if # (this category id exists in posts) OR
# 		# (subscribers contains this foreign key AND kind: category)
# 		# message = "You cannot delete a category with associations"
# 	else
# 		category.destroy
# 	end

# 	redirect "/new/category"
# end





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
  erb(:"index", { locals: { posts: Post.all(), comments: Comment.all(), categories: Category.all()  } })
end

get("/posts/:id") do
	post = Post.find_by( id: params[:id] )
  	erb(:"posts/post", { locals: { posts: Post.all(), post: post, comments: Comment.all(), categories: Category.all()  } })
end

get("/new/post") do
	erb(:"posts/post_new", { locals: { posts: Post.all(), comments: Comment.all(), categories: Category.all()  } })
end

get("/categories/:id/posts") do
	erb(:"categories/category", { locals: { posts: Post.all(), comments: Comment.all(), category: Category.find_by_id(params[:id])  } })
end

get("/category_search") do 
	redirect "/categories/#{params[:id]}/posts"
end 

get("/new/category") do
	erb(:"categories/category_new", { locals: { posts: Post.all(), comments: Comment.all(), categories: Category.all()  } })
end

post("/new/category") do
	category_hash = {
		name: params["name"],
		description: params["description"]
	}

	if 
		category_hash["name"] #exists
		# don't make it again
		message = "That category already exists"
	else
		Category.create(category_hash)
	end

	erb(:"categories/category_new", { locals: { posts: Post.all(), comments: Comment.all(), categories: Category.all()  } })
end
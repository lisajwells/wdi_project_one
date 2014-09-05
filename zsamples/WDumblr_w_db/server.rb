require_relative './lib/connection'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'httparty'
require 'json'
require_relative './lib/author'
require_relative './lib/post'



get("/") do
	erb(:index)
end

get("/posts") do
	erb(:posts, { locals: { posts: Post.all() } })
end

get("/posts/new") do
	erb(:new_post, { locals: { authors: Author.all() } })
end

post("/posts") do
	post_hash = {
		title: params["title"],
		keyword: params["keyword"],
		created_at: params["created_at"],
		content: params["content"],
		author_id: params["author_id"]
	}

	Post.create(post_hash)

	erb(:posts, { locals: { posts: Post.all() } })
end

post("/authors") do
	author_hash = {
		name: params["name"],
		email: params["email"]
	}

	Author.create(author_hash)

	erb(:authors, { locals: { authors: Author.all() } })
end


get("/authors") do
	erb(:authors, { locals: { authors: Author.all() } })
end

get("/authors/new") do
	erb(:new_author, { locals: { posts: Post.all() } })
end

get("/posts/:id") do
	post = Post.find_by(id: params[:id])
	images = post.images
	post_author = post.author
	erb(:post, { locals: { post: post, post_author: post_author, images: images } })
end

post("/posts/:id/images") do
	post = Post.find_by(id: params[:id])
	# find the keyword of post
	keyword = Post.find_by(id: params["id"])["keyword"]
	
	i = 0
	3.times do 
		response = HTTParty.get("https://api.instagram.com/v1/tags/#{keyword}/media/recent?client_id=4ad7cc36c172434588afd340aa74cd01")

		image_hash = {
			keyword: keyword,
			post_id: post["id"],
			image_url: response["data"][i]["images"]["low_resolution"]["url"],
		}
		Image.create(image_hash)
		i += 1
	end

	images = post.images
	post_author = post.author

	erb(:post, { locals: { post: post, keyword: keyword, images: images, post_author: post_author } })
end

get("/authors/:id") do
	author = Author.find_by(id: params[:id])
	erb(:author, { locals: { author: author } })
end
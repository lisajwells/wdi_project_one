require_relative './model'
require_relative './author'
require_relative './post'

class Image < ActiveRecord::Base

	 def post
	 	Post.find_by(id: @attributes["post_id"])
	 end


end

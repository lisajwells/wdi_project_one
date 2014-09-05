require_relative './model'
require_relative './image'
require_relative './post'

class Author < ActiveRecord::Base

	 def posts
	 	Post.where(author_id: @attributes["id"])
	 end


end

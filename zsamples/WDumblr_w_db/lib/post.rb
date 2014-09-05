require_relative './model'
require_relative './image'
require_relative './author'

class Post < ActiveRecord::Base

	 def author
	 	Author.find_by(id: @attributes["author_id"])
	 end

	 def images
	 	Image.where(post_id: @attributes["id"])
	 end


end



# Joe's before and after
# return Author.find_by("id", @attributes["author_id"])

# return Author.find_by(id: @attributes["author_id"])

#		return Image.where(post_id: @attributes["id"])

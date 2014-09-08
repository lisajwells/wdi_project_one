require 'active_record'

# for a Comment, I want to be able to find
# Post


class Comment < ActiveRecord::Base
  def post
     Post.find_by(id: self.post_id)
  end
end
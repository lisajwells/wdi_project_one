require 'active_record'

# for a Post, I want to be able to find
# Category, Comments, Subscribers


class Post < ActiveRecord::Base
  def category
     Category.find_by(id: self.category_id)
  end

  def comments
     Comment.where(post_id: self.id)
  end

  def subscribers
     Subscriber.where( kind: 'post', foreign_key: self.id)
  end




end

 # && foreign_key: self.id
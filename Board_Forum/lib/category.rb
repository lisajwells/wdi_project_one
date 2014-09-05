require 'active_record'

# for a Category, I want to be able to find
# Subscribers, Posts


class Category < ActiveRecord::Base

  def subscribers
     Subscriber.where(kind: 'category', foreign_key: self.id)
  end

  def posts
     Post.where(category_id: self.id)
  end



end

 # && 
require 'active_record'

# for a Subscriber, I want to be able to find
# Category or Post


class Subscriber < ActiveRecord::Base





  # def kind
  #    if 
  #    	self.kind == "post"
  #    	Post.find_by(id: self.foreign_key)
  #    else
  #    	Category.find_by(id: self.foreign_key)
  #    end
  # end



end



# In order to maintain only one table for all my Subscribers, I (like Trish) have the data key Kind, which has 2 possible values (category or post). Then there is a key Foreign_key, which can be searched for. So whenever I would normally search for the foreign_key, I need ... if statements? (if :kind == "post" && foreign_key == self.
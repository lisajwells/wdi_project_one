require 'active_record'

class House < ActiveRecord::Base
  def characters
    Character.where({house_id: self.id})
  end
end
require 'active_record'

class Character < ActiveRecord::Base
  def house
    House.find_by({id: self.house_id})
  end
end
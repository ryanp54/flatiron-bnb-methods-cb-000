class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  extend Area::ClassMethods
  include Area::InstanceMethods

  def city_openings(checkin, checkout)
    self.openings(checkin, checkout)    
  end
end


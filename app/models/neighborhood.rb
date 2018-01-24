class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  
  extend Area::ClassMethods
  include Area::InstanceMethods


  def neighborhood_openings(checkin, checkout)
    self.openings(checkin, checkout)    
  end
end

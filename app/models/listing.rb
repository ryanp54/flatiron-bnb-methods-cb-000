class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  validates :address, presence: {is: true}
  validates :price, presence: {is: true}
  validates :description, presence: {is: true}
  validates :listing_type, presence: {is: true}
  validates :title, presence: {is: true}
  validates :neighborhood, presence: {is: true}

  before_create :activate_host
  before_destroy :deactivate_host

  def activate_host
  	self.host.host = true
  	self.host.save  	
  end
  def deactivate_host
  	if self.host.listings.count == 1
	  	self.host.host = false
	  	self.host.save
	  end
  end  

  def average_review_rating
  	total_stars = 0
  	self.reviews.each do |review|
  		total_stars += review.rating
  	end
  	total_stars.to_f / self.reviews.count.to_f
  end

end

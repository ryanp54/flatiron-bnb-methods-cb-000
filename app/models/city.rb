class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def self.highest_ratio_res_to_listings
  	max_ratio = 0
  	max_city = nil
  	self.all.each do |city|
  		res_count = city.reservation_count
  		res_to_listing = res_count / city.listings.count
  		if res_to_listing > max_ratio
  			max_ratio = res_to_listing
  			max_city = city
  		end
  	end
  	max_city
  end

  def self.most_res
  	max_res = 0
  	max_city = nil
  	self.all.each do |city|
  		if city.reservation_count > max_res
  			max_res = city.reservation_count
  			max_city = city
  		end
  	end
  	max_city
  end

  def reservation_count
  	res_count = 0
		self.listings.each do |listing|
			res_count += listing.reservations.count
		end
		res_count
  end

  def city_openings(checkin, checkout)
  	checkin = Date.parse(checkin)
  	checkout = Date.parse(checkout)
  	self.listings.collect do |listing|
  		overlaps = listing.reservations.collect do |reservation|
  			if (reservation.checkout > checkin and reservation.checkin < checkout)
  				true
  			else
  				false
  			end
  		end
			if !overlaps.include?(true)
				listing
  		else
  			nil
  		end
  	end
  end

end


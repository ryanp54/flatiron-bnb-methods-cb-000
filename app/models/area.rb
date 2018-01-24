module Area
	module ClassMethods
		
	  def highest_ratio_res_to_listings
	  	max_ratio = 0
	  	max_area = nil
	  	self.all.each do |area|
	  		res_count = area.reservation_count
	  		area.listings.count == 0 ? res_to_listing = 0 : res_to_listing = res_count / area.listings.count
	  		if res_to_listing > max_ratio
	  			max_ratio = res_to_listing
	  			max_area = area
	  		end
	  	end
	  	max_area
	  end

	  def most_res
	  	max_res = 0
	  	max_area = nil
	  	self.all.each do |area|
	  		if area.reservation_count > max_res
	  			max_res = area.reservation_count
	  			max_area = area
	  		end
	  	end
	  	max_area
	  end

	end
	
	module InstanceMethods

	  def reservation_count
	  	res_count = 0
			self.listings.each do |listing|
				res_count += listing.reservations.count
			end
			res_count
	  end

	  def openings(checkin, checkout)
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
	
	
end
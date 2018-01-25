class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  has_one :host, through: :listing

  validates :checkin, presence: {is: true}
  validates :checkout, presence: {is: true}

  validate :host_not_guest
  validate :in_before_out
  validate :available

  def available
		if checkin and checkout and !listing.available?(checkin, checkout)
			errors.add(:base, 'listing not available for those dates')
		end
  end

  def host_not_guest
  	if guest == listing.host
  		errors.add(:base, 'guest and host cannot be the same')
  	end
  end

  def in_before_out
  	if checkin and checkout and checkin >= checkout
  		errors.add(:base, 'checkin must be before checkout')
  	end
  end

  def duration
  	(checkout - checkin).to_i
  end

  def total_price
  	listing.price * duration
  end

end

class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :description, presence: {is: true}
  validates :rating, presence: {is: true}
  validates :reservation, presence: {is: true}

  validate :stay_completed

  def stay_completed
  	if reservation and reservation.checkout - Date.today > 0
  		errors.add(:reservation, 'not completed')
  	end
  end

end

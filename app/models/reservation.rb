class Reservation < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validate :check_end_date

   def check_end_date
    if @reservation.end < @reservation.start
      errors.add(:end, "must be after the start date")
    end
  end
end

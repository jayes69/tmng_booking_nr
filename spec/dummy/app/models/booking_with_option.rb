class BookingWithOption < ActiveRecord::Base #:nodoc:
  acts_as_booking_nr_generator :body_length => 7,
                               :delimiter => '_',
                               :booking_nr_field => :booking_number
end

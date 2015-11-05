require 'spec_helper'
require 'tmng_booking_nr'

RSpec.describe TMNGBookingNr do
  let(:booking) { Booking.new }
  let(:booking_with_options) { BookingWithOption.new }

  describe 'acts_as_booking_nr_generator' do
    it 'does not raise an error' do
      expect { Booking }.not_to raise_error
    end

    it 'adds the generate_booking_nr method' do
      expect { booking.generate_booking_nr }.not_to raise_error
    end

    context 'when options :body_length, :delimiter' do
      it 'does not raise an error' do
        expect { BookingWithOption }.not_to raise_error
      end

      it 'adds the generate_booking_nr method' do
        expect { booking_with_options.generate_booking_nr }.not_to raise_error
      end
    end
  end

  describe '#generate_booking_nr' do
    before(:each) do
      booking.generate_booking_nr
      booking.save
    end
    before(:each) do 
      booking_with_options.generate_booking_nr
      booking.save
    end

    it 'generates a booking_nr_body' do
      expect(booking.booking_nr_body).not_to be_nil
    end

    it 'increments the booking_nr_body by 1' do
      new_booking = Booking.new
      new_booking.generate_booking_nr
      expect(booking.booking_nr_body.to_i + 1).to be new_booking.booking_nr_body.to_i
    end

    it 'does not populate the booking_nr_prefix field' do
      expect(booking.booking_nr_prefix).to be_nil
    end

    it 'does not populate the booking_nr_postfix field' do
      expect(booking.booking_nr_postfix).to be_nil
    end

    it 'populates the booking_nr field' do
      expect(booking.booking_nr).not_to be_nil
    end

    it 'generates a 14 digit booking_nr' do
      booking_nr_string = booking.booking_nr.to_s
      expect(booking_nr_string.length).to be 14
    end

    context 'with arguments :prefix and :postfix' do
      before(:each) do
        booking.generate_booking_nr :prefix => '01',
                                    :postfix => '02'
      end

      it 'populates the booking_nr_prefix field' do
        expect(booking.booking_nr_prefix).to eq '01'
      end

      it 'populates the booking_nr_postfix field' do
        expect(booking.booking_nr_postfix).to eq '02'
      end
    end

    context 'when option :body_length' do
      it 'sets the body_length options' do
        body_length_option = BookingWithOption.booking_nr_options[:body_length]
        expect(body_length_option).to be 7
      end

      it 'sets the length of booking_nr_body' do
        p BookingWithOption.booking_nr_options[:body_length], booking_with_options.booking_nr_body, '!=!=!=!='
        expected_length = BookingWithOption.booking_nr_options[:body_length]
        actual_length = booking_with_options.booking_nr_body.to_s.length
        expect(actual_length).to be expected_length
      end
    end

    context 'when option :delimiter' do
      it 'sets the delimiter option' do
        delimiter = BookingWithOption.booking_nr_options[:delimiter]
        expect(delimiter).to eq '_'
      end

      it 'generates a booking_nr with a different delimiter' do
        delimiter = BookingWithOption.booking_nr_options[:delimiter]
        expect(booking_with_options.booking_number).to include(delimiter)
      end
    end

    context 'when option :booking_nr_field' do
      it 'sets the booking_nr_field option' do
        field = BookingWithOption.booking_nr_options[:booking_nr_field]
        expect(field.to_s).to eq 'booking_number'
      end

      it 'populates the field referenced in the option' do
        expect(booking_with_options.booking_number).not_to be_nil
      end
    end
  end
end

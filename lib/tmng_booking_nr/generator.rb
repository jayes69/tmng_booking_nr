module TMNGBookingNr
  module Generator
    extend ActiveSupport::Concern

    def generate_booking_nr(opts = {})
      self.booking_nr_prefix = opts[:prefix] || '00'
      self.booking_nr_postfix = opts[:postfix] || Date.today.year
      self.booking_nr_body = build_booking_nr_body

      bokking_nr_field = self.class.booking_nr_options[:booking_nr_field]
      send "#{bokking_nr_field}=", self.class.build_booking_nr(self)
    end

    def build_booking_nr_body
      uncached do
        current_nr =
          self.class.select(:booking_nr_body).where(:booking_nr_prefix => booking_nr_prefix.to_s).last.try(:booking_nr_body)
      end
      b_nr_body = current_nr.to_i + 1
      b_length = self.class.booking_nr_options[:body_length]

      b_nr_body.to_s.rjust(b_length, '0')
    end

    module ClassMethods #:nodoc:
      def build_booking_nr(record)
        prefix = record.booking_nr_prefix
        postfix = record.booking_nr_postfix
        nr_body = record.booking_nr_body

        format_booking_nr prefix, nr_body, postfix
      end

      def format_booking_nr(prefix, nr_body, postfix)
        preformated =
          "#{prefix}#{nr_body}"
          .chars.each_slice(4).map(&:join)
        preformated << postfix
        preformated.join booking_nr_options[:delimiter]
      end
    end
  end
end

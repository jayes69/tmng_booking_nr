module TMNGBookingNr
  module Generator
    extend ActiveSupport::Concern

    def generate_booking_nr(opts = {})
      self.booking_nr_body = build_booking_nr_body
      self.booking_nr_prefix = opts[:prefix]
      self.booking_nr_postfix = opts[:postfix]

      bokking_nr_field = self.class.booking_nr_options[:booking_nr_field]
      send "#{bokking_nr_field}=", self.class.build_booking_nr(self)
    end

    module ClassMethods #:nodoc:
      def build_booking_nr(record)
        prefix = record.booking_nr_prefix || '00'
        postfix = record.booking_nr_postfix || Date.today.year
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

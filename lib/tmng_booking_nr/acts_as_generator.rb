module TMNGBookingNr
  module ActsAsBookingNrGenerator
    extend ActiveSupport::Concern

    def build_booking_nr_body
      ActiveRecord::Base.transaction do
        current_nr = self.class.select(:booking_nr_body).last.try(:booking_nr_body)
        booking_nr_body = current_nr.to_i + 1
        b_length = self.class.booking_nr_options[:body_length]

        self.booking_nr_body =
          booking_nr_body.to_s.rjust(b_length, '0')
      end
    end

    module ClassMethods #:nodoc:
      def acts_as_booking_nr_generator(opts = {})
        include TMNGBookingNr::Generator
        self.booking_nr_options = opts
      end

      def booking_nr_options=(opts)
        validate_opts! opts
        @_booking_nr_options = normalize_opts(opts)
      end

      def booking_nr_options
        @_booking_nr_options ||= {}
      end

      private

        def validate_opts!(opts)
          valid_keys = [:body_length, :delimiter, :booking_nr_field]
          fail ArgumentError, 'Invalid Options' if (opts.keys - valid_keys).any?
        end

        def normalize_opts(opts)
          {
            :body_length => opts[:body_length] ||= 6,
            :delimiter => opts[:delimiter] ||= '-',
            :booking_nr_field => opts[:booking_nr_field] || 'booking_nr'
          }
        end
    end
  end
end

ActiveRecord::Base.send :include, TMNGBookingNr::ActsAsBookingNrGenerator

module TMNGBookingNr
  module ActsAsBookingNrGenerator
    extend ActiveSupport::Concern

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

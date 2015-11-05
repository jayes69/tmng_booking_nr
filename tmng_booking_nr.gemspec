$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tmng_booking_nr/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tmng_booking_nr"
  s.version     = TmngBookingNr::VERSION
  s.authors     = ["Ninigi"]
  s.email       = ["fabian.zitter@net-up.de"]
  s.homepage    = "TODO"
  s.summary     = "Creates a BookingNr according to TMNG specs."
  s.description = "Use acts_as_booking_nr_generator in an ActiveRecord model."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 3.2"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
end

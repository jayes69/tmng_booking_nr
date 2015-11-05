class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.string :booking_nr_prefix
      t.string :booking_nr_body
      t.string :booking_nr_postfix
      t.string :booking_nr

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :bookings
  end
end

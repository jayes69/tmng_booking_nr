class CreateBookingWithOptions < ActiveRecord::Migration
  def self.up
    create_table :booking_with_options do |t|
      t.string :booking_nr_body
      t.string :booking_nr_prefix
      t.string :booking_nr_postfix
      t.string :booking_number

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :booking_with_options
  end
end

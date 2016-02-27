class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.boolean :rsvp, default: false
      t.integer :wedding_id
    end
  end
end

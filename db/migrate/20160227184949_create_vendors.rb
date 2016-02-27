class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.integer :cost
      t.integer :wedding_id
      t.string :title
    end
  end
end

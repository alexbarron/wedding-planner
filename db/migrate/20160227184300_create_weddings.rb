class CreateWeddings < ActiveRecord::Migration
  def change
    create_table :weddings do |t|
      t.string :name
      t.string :location
      t.datetime :date
      t.integer :user_id
    end
  end
end

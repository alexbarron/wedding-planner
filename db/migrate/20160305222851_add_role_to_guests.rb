class AddRoleToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :role, :string, default: "None"
  end
end

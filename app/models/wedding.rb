class Wedding < ActiveRecord::Base
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :vendors, dependent: :destroy

  def formatted_date
    self.date.strftime("%A %B %e, %Y")
  end

  def confirmed_guests
    self.guests.select {|guest| guest.rsvp }
  end

  def total_vendor_cost
    self.vendors.inject(0){|sum, vendor| sum + vendor.cost }
  end

  def avg_vendor_cost
    total_vendor_cost / self.vendors.count
  end

end
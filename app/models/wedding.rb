class Wedding < ActiveRecord::Base
  belongs_to :user
  has_many :guests
  has_many :vendors

  def formatted_date
    self.date.strftime("%A %B %e, %Y")
  end

end
class Wedding < ActiveRecord::Base
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :vendors, dependent: :destroy

  def formatted_date
    self.date.strftime("%A %B %e, %Y")
  end

end
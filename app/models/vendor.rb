class Vendor < ActiveRecord::Base
  belongs_to :wedding
  validates_presence_of :name
  validates :cost, numericality: true

  def display
    if self.title == ""
      return self.name
    else
      return self.title + ": " + self.name
    end
  end
end
class Vendor < ActiveRecord::Base
  belongs_to :wedding
  validates_presence_of :name
  validates :cost, numericality: true
  
end
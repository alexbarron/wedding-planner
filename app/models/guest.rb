class Guest < ActiveRecord::Base
  belongs_to :wedding
  validates_presence_of :name
  
end
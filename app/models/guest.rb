class Guest < ActiveRecord::Base
  belongs_to :wedding
  validates_presence_of :name

  def display
    if self.role == ""
      return self.name
    else
      return self.role + ": " + self.name
    end
  end
end
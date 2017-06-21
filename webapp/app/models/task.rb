class Task < ActiveRecord::Base

  def self.check_invalid_houses
    houses = House::where(:is_available => true).where(disable_at: 1.week.ago..Date.today)
    houses.update_all(is_available: false)
  end

end

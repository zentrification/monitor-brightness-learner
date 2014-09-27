# gem install ruby-sun-times
require 'sun_times'

class Sun
  @@lat = 42.3581
  @@lng = -71.0636

  def initialize(day = Time.now)
    @day = day
  end

  def rise
    SunTimes.new.rise(@day, @@lat, @@lng)
  end

  def set
    SunTimes.new.set(@day, @@lat, @@lng)
  end
end

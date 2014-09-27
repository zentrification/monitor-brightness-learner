class Logger

  def self.log
    BrightnessData.create(
      left:       Monitor.new(:left).get_brightness,
      middle:     Monitor.new(:middle).get_brightness,
      right:      Monitor.new(:right).get_brightness,
      color_temp: Logger.color_tmp,
      light:      Logger.light_sensor,
      sunrise:    Sun.new.rise,
      sunset:     Sun.new.set,
      time:       Time.now,
    )
  end

  def self.color_tmp
    `redshift -p | grep temp`.match(/(\d\d\d\d)K/).captures.first
  end

  def self.light_sensor
    `tail -n 1 /var/log/lightsensor.log | cut -d: -f4`
  end

  def self.seed
    [[70, 90, 70, 16],
    [80, 100, 80, 10],
    [20, 60, 20, 8]].each do |(left, middle, right, time)|
      time = Time.now - time.hours
      time = time.hour * 60 + time.min
      BrightnessData.create(
        left:       left,
        middle:     middle,
        right:      right,
        color_temp: Logger.color_tmp,
        light:      Logger.light_sensor,
        sunrise:    Sun.new.rise,
        sunset:     Sun.new.set,
        time:       time,
      )
    end
    p BrightnessData.count
  end

end

class Monitor
  def initialize(identifier)
    @device = find_device(identifier)
  end

  def get_brightness
    `sudo ddccontrol dev:/dev/i2c-#{@device} -r 0x10 2>&1 | grep -i brightness`.split('/')[1]
  end

  def set_brightness(brightness)
    brightness = get_brightness.to_i + brightness.to_i if %w(+ -).include?(brightness[0])
    `sudo ddccontrol dev:/dev/i2c-#{@device} -r 0x10 -w #{brightness} 2>/dev/null`
  end

  protected

  def find_device(identifier)
    case identifier
      when :left   then 6
      when :middle then 5
      when :right  then 7
    end
  end
end


require 'active_record'
require 'sqlite3'

# http://snippets.aktagon.com/snippets/257-how-to-use-activerecord-without-rails

class Schema < ActiveRecord::Migration
  def change
    create_table :brightness_data do |t|
      t.integer  :left
      t.integer  :middle
      t.integer  :right
      t.integer  :color_temp
      t.integer  :light
      t.datetime :sunrise
      t.datetime :sunset
      t.datetime :time
    end
  end
end

class BrightnessData < ActiveRecord::Base
  def to_training_inputs
    [color_temp, light] | [sunrise, sunset, time].map { |x| minute_offset(x) }
  end

  def to_training_outputs
    [left, middle, right].map { |x| x / 100.0 }
  end

  protected

  def minute_offset(time)
    time.hour * 60 + time.min
  end
end

ActiveRecord::Base.configurations = {
  'development' => {
    'adapter' => 'sqlite3',
    'database' => '/home/chris/var/brightness_data.sqlite3'
  }
}
ActiveRecord::Base.establish_connection(:development)

# hrm what to do about running this ?
#Schema.new.change

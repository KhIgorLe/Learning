require_relative 'company'
require_relative 'valid'

class Wagon
  include Company
  include Valid
  attr_reader :number, :full_volume, :occupied_volume

  def initialize(number, full_volume)
    @number = number
    @full_volume = full_volume
    @occupied_volume = 0
    @empty_volume = full_volume
    validate!
  end

  def take_volume(volume)
    @occupied_volume += volume if volume <= empty_volume
    empty_volume
  end

  def empty_volume
    @empty_volume = @full_volume - @occupied_volume
  end

  protected

  def validate!
    raise "Номер вагона не может быть пустым" if @number.nil?
  end
end

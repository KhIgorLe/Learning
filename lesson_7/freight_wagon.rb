require_relative 'wagon'

class FreightWagon < Wagon

  attr_reader :total_volume, :occupied_volume

  def initialize(number, total_volume)
    super(number)
    @total_volume = total_volume
    @occupied_volume = 0
    @available_volume = total_volume
  end

  def take_volume(volume)
    @occupied_volume += volume if volume <= available_volume
    available_volume
  end

  def available_volume
    @available_volume = @total_volume - @occupied_volume
  end
end

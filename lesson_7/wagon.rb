require_relative 'company'
require_relative 'valid'

class Wagon
  include Company
  include Valid
  attr_reader :number, :quantity_all_places_or_volume, :quantity_occupied_places_or_volume

  def initialize(number, quantity_all_places_or_volume)
    @number = number
    @quantity_all_places_or_volume = quantity_all_places_or_volume
    @quantity_occupied_places_or_volume = 0
    @quantity_empty_places_or_volume = quantity_all_places_or_volume
    validate!
  end

  def take_place_or_volume(volume)
    @quantity_occupied_places_or_volume += volume if volume <= quantity_empty_places_or_volume
    quantity_empty_places_or_volume
  end

  def quantity_empty_places_or_volume
    @quantity_empty_places_or_volume = @quantity_all_places_or_volume - @quantity_occupied_places_or_volume
  end

  protected

  def validate!
    raise "Номер вагона не может быть пустым" if @number.nil?
  end
end

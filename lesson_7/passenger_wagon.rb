require_relative 'wagon'

class PassengerWagon < Wagon

  attr_reader :quantity_all_places, :quantity_occupied_places

  def initialize(number, quantity_all_places)
    super(number)
    @quantity_all_places = quantity_all_places
    @quantity_occupied_places = 0
    @quantity_empty_places = quantity_all_places
  end

  def take_place
    @quantity_occupied_places += 1 if @quantity_occupied_places < @quantity_all_places
    quantity_empty_places
  end

  def quantity_empty_places
    @quantity_empty_places = @quantity_all_places - @quantity_occupied_places
  end
end

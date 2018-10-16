require_relative 'wagon'

class PassengerWagon < Wagon
  def take_place_or_volume
    super(1)
  end
end

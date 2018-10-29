require_relative 'wagon'

class PassengerWagon < Wagon
  def take_place
    take_volume(1)
  end
end

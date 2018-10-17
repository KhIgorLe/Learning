require_relative 'wagon'

class PassengerWagon < Wagon
  def take_volume
    super(1)
  end
end

require_relative 'train'
require_relative 'freight_wagon'
class CargoTrain < Train
  def initialize(number)
    super(number, "Грузовой")
  end

  def accept_class_wagon
    FreightWagon
  end
end

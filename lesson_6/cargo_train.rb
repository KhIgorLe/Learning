class CargoTrain < Train
  def initialize(number)
    super(number, "Грузовой")
  end

  def accept_class_wagon
    FreightWagon
  end
end

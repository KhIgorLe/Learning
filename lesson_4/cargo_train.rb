class CargoTrain < Train
  def initialize(number)
    super(number, "Грузовой")
  end

  def add_wagon(wagon)
    super if wagon.is_a? FreightWagon
  end
end

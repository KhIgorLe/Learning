class CargoTrain < Train
  def add_wagon(wagon)
    super if wagon.is_a? FreightWagon
  end
end

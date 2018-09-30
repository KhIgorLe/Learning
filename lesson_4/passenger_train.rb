class PassengerTrain < Train
  def initialize(number)
    super(number, "Пассажирский")
  end

  def accept_class_wagon
    PassengerWagon
  end
end

class PassengerTrain < Train
  def initialize(number)
    super(number, type: 'Пассажирский')
  end

  def accept_class_wagon
    PassengerWagon
  end
end

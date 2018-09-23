=begin
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется
из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :trains, :name

  def initialize(name_station)
    @name = name_station
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def count_train_type(type)
    @trains.count { |train| train.type.eql?(type) }
  end

  def send_train(train)
    @trains.delete(train)
  end
end

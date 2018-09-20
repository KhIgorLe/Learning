=begin
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется
из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :list_trains
  attr_reader :name_station

  def initialize(name_station)
    @name_station = name_station
    @list_trains = []
  end

  def take_train(train)
    @list_trains << train
    puts "Поезд номер #{train.number_train} прибыл на станцию"
  end

  def show_list_train
    @list_trains.each { |train| puts "Поезд #{train.number_train} находится на станции"}
  end

  def show_train_by_type(type)
    count_type = 0
    @list_trains.each { |train| count_type += 1 if train.type.eql?(type) }
    puts "Поезд #{type} - количество #{count_type}"   
  end

  def send_train(train)
    @list_trains.delete(train)
    puts "Поезд #{train.number_train} отправился со станции"
  end
end

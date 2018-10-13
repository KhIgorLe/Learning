=begin
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются
при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов
Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
метод просто увеличивает или уменьшает количество вагонов).
Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route).
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end
require_relative 'company'
require_relative 'instance_counter'
require_relative 'valid'

class Train
  include Company
  include InstanceCounter
  include Valid

  attr_reader :speed, :type, :route, :number, :wagons

  NUMBER_FORMAT = /^[а-я0-9ё]{3}-?[а-я0-9ё]{2}$/i

  @@trains = {}


  def initialize(number, type, speed = 0)
    @number = number
    @type = type
    @speed = speed
    @wagons = []
    validate!
    @@trains[number] = self
    register_instance
  end

  def self.all
    @@trains
  end

  def self.find(number)
    @@trains[number]
  end

  def go(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed -= speed if @speed > speed
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed == 0 && wagon.is_a?(accept_class_wagon)
  end

  def del_wagon(wagon)
    @wagons.delete(wagon) if @speed == 0
  end

  def current_station
    @route.stations[@index_station]
  end

  def take_route(route)
    @route = route
    @index_station = 0
    station_take_train
  end

  def go_next_station
    if next_station
      station_send_train
      @index_station += 1
      station_take_train
    end
  end

  def go_previouse_station
    if previouse_station
      station_send_train
      @index_station -= 1
      station_take_train
    end
  end

  def next_station
    @route.stations[@index_station + 1]
  end

  def previouse_station
    @route.stations[@index_station - 1] if @index_station > 0
  end

  protected

  # метод station_take_train - сообщает станции о прибытии поезда на станцию,
  # был вынесен в protected потомучто данный метод вызывается только из класса Train
  # и не вызывается из клиенского кода, метод доступен в подклассе CargoTrain и PassengerTrain
  def station_take_train
    current_station.take_train(self)
  end

  # station_send_train - отправляет поезд со станции на станцию по маршруту,
  # был вынесен в protected потомучто данный метод вызывается только из класса Train
  # и не вызывается из клиенского кода, метод доступен в подклассе CargoTrain и PassengerTrain
  def station_send_train
    current_station.send_train(self)
  end

  def validate!
    raise "Номер поезда не может быть nil" if @number.nil?
    raise "Тип поезда не может быть nil" if @type.nil?
    raise "Номер поезда имеет неверный формат" if @number !~ NUMBER_FORMAT
  end
end

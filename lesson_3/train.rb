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

class Train
  attr_reader :speed, :number_wagons, :type, :stations, :current_station, :number
  attr_reader :next_station, :previouse_station

  def initialize(number, type, number_wagons, speed = 0)
    @number = number
    @type = type
    @number_wagons = number_wagons
    @speed = speed
  end

  def go(speed)
    @speed += speed 
  end

  def decrease_speed(speed)
    @speed -= speed if @speed > speed
  end

  def add_wagon
    @number_wagons += 1 if @speed == 0
  end

  def del_wagon
    @number_wagons -= 1 if @speed == 0 && @number_wagons.positive?
  end

  def current_station
    @current_station = @stations[@index_station]
  end

  def take_route(route)
    @stations = route.stations
    @index_station = 0
    current_station
    station_take_train
  end

  def station_take_train
    @current_station.take_train(self)
  end

  def go_next_station
    if @index_station < @stations.length - 1
      @index_station += 1
      current_station
      station_take_train
    end
  end
  
  def go_previouse_station
    if @index_station > 0
      @index_station -= 1
      current_station
      station_take_train
    end
  end

  def next_station
    @next_station = @stations[@index_station + 1]
  end

  def previouse_station
    @previouse_station = @stations[@index_station - 1] if @index_station > 0
  end
end


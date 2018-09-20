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
  attr_accessor :speed
  attr_reader :number_wagons
  attr_reader :type       
  attr_reader :route
  attr_reader :current_station
  attr_reader :first_station
  attr_reader :current_station_number
  attr_reader :number_train

  def initialize(number_train, type, number_wagons, speed = 0)
    @number_train = number_train
    @type = type
    @number_wagons = number_wagons
    @speed = speed
    @current_station_number = 0
  end

  def go(speed)
    self.speed += speed 
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    @number_wagons += 1 if self.speed == 0
  end

  def del_wagon
    @number_wagons -= 1 if self.speed == 0
  end

  def take_route(route)
    @route = route.list_station
    @current_station = route.list_station[0] 
  end

  def go_next_station(route)
    @current_station_number += 1
    @current_station = route.list_station[self.current_station_number] 
  end

  def go_back_station(route)
    @current_station_number -= 1
    @current_station = route.list_station[self.current_station_number]
  end

  def show_next_station(route)
    @show_next_station = route.list_station[@current_station_number + 1]
  end

  def show_back_station(route)
    @show_back_station = route.list_station[@current_station_number - 1]
  end
end

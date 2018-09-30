=begin
Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
     - Создавать станции
     - Создавать поезда
     - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
     - Назначать маршрут поезду
     - Добавлять вагоны к поезду
     - Отцеплять вагоны от поезда
     - Перемещать поезд по маршруту вперед и назад
     - Просматривать список станций и список поездов на станции

В качестве ответа приложить ссылку на репозиторий с решением
=end

require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'freight_wagon'
require_relative 'route'
require_relative 'station'

class Main
  MAIN_MENU = <<-MENU
    Выберите пункт меню:
    Введите 1 - cоздавать станции
    Введите 2 - создавать поезда
    Введите 3 - создавать маршруты
    Введите 4 - добавить станцию в маршрут
    Введите 5 - удалить станцию в маршруте 
    Введите 6 - назначать маршрут поезду
    Введите 7 - Добавлять вагоны к поезду
    Введите 8 - Отцеплять вагоны от поезда
    Введите 9 - Перемещать поезд по маршруту вперед
    Введите 10 - Перемещать поезд по маршруту назад
    Введите 11 - Просматривать список станций и список поездов на станции
    Введите 0 - Выйти из программы
  MENU

  def initialize
    @stations = []
    @routs = []
    @trains = []
    @wagons = []
    @count_stations = 0
  end

  def run
    command = ""
    while command != 0
      puts MAIN_MENU
      command = gets.to_i
      case command
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then add_station_in_route
      when 5 then del_station_in_route
      when 6 then take_route_for_train
      when 7 then add_wagon_for_train
      when 8 then del_wagon_for_train
      when 9 then move_train_route_forward
      when 10 then move_train_route_back
      when 11 then show_information
      when 0 then break
      else
        puts "Команда введена не правильно"
      end
    end
  end

  private

  def create_station
    puts "Введите название станции"
    name = gets.chomp
    if station_present?(name)
      puts "Станция уже существует"
    else
      @stations << Station.new(name)
      @count_stations += 1
      puts "Станция #{name} создана"
    end
  end

  def station_present?(name)
    @stations.map(&:name).include?(name)
  end

  def create_train
    puts "Введите номер поезда"
    number = gets.chomp
    puts "Выберите 1 - создать пассажирский, 2 - создать грузовой поезд"
    choise = gets.to_i
    case choise
    when 1
      train = PassengerTrain.new(number)
      @trains << train
      puts "Пассажирский поезд номер #{number} создан"
    when 2
      train = CargoTrain.new(number)
      @trains << train
      puts "Грузовой поезд номер #{number} создан"
    end
  end

  def create_route
    if @stations.empty?
      station_text
      puts "Необходимо как минимум две станции"
    elsif @count_stations < 2
      puts "Для создания маршрута необходимо создать две станции, первая станция уже создана"
    else
      route = Route.new(@stations.first, @stations.last)
      @routs << route
      puts "Маршрут #{@stations.first.name} - #{@stations.last.name} создан"
    end
  end

  def add_station_in_route
    if @stations.empty?
      station_text
    elsif @routs.empty?
      puts "Вы не создали маршрут"
    else
      get_route.add_intermediate_station(get_station)
    end
  end

  def del_station_in_route
    if @stations.empty?
      station_text
    elsif @routs.empty?
      puts "Вы не создали маршрут"
    else
      get_route.del_intermediate_station(get_station)
    end
  end

  def take_route_for_train
    if @routs.empty?
      puts "Вы не создали маршрут"
    elsif @trains.empty?
      create_train_text
    else
      get_train.take_route(get_route)
    end
  end

  def add_wagon_for_train
    if @trains.empty?
      create_train_text
    else
      train = get_train
      return if train.speed != 0
      wagon_class = train.accept_class_wagon
      select_wagon_text
      number_wagon = gets.to_i
      wagon = wagon_class.new(number_wagon)
      train.add_wagon(wagon)
      @wagons << wagon
    end
  end

  def del_wagon_for_train
    if @trains.empty?
      create_train_text
    elsif @wagons.empty?
      puts "Добавьте вагон к поезду"
    else
      train = get_train
      train.del_wagon(get_wagon) if train.speed == 0
    end
  end

  def move_train_route_forward
    if @trains.empty?
      create_train_text
    else
      get_train.go_next_station
    end
  end

  def move_train_route_back
    if @trains.empty?
      create_train_text
    else
      get_train.go_previouse_station
    end
  end

  def show_information
    @stations.each do |station|
      puts "Станция #{station.name}:"
      station.trains.each { |train| puts "Поезд #{train.number}"}
    end
  end

  def get_train
    @trains.each_with_index { |train, number| puts "поезд #{train.number} - номер #{number}" }
    puts "Выберите номер поезд"
    train = gets.to_i
    @trains[train]
  end

  def get_route
    @routs.each_with_index { |route, number| puts "маршрут #{route.name} - номер #{number}" }
    puts "Введите номер маршрута"
    number_route = gets.to_i
    @routs[number_route]
  end

  def get_station
    @stations.each_with_index { |station, number| puts "станция #{station.name} - номер #{number}"}
    puts "Введите номер станции"
    number_station = gets.to_i
    @stations[number_station]
  end

  def get_wagon
    @wagons.each_with_index {|wagon, number| puts "Вагон номер #{wagon.number} - номер #{number}"}
    select_wagon_text
    wagon = gets.to_i
    @wagons[wagon]
  end

  def station_text
    puts "Вы не создали станцию"
  end

  def create_train_text
    puts "Создайте поезд"
  end

  def select_wagon_text
    puts "Введите номер вагона"
  end
end

Main.new.run

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
    @stations << Station.new(name)
    @count_stations += 1
    puts "Станция #{name} создана"
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
      puts "Для создания маршрута необходимо создать две станции"
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
      puts "Вы не создали станцию"
    elsif @routs.empty?
      puts "Вы не создали маршрут"
    else
      @routs.each_with_index do |route, number|
        puts "маршрут #{route.name} - номер #{number}"
      end
      puts "Введите номер маршрута"
      number_route = gets.to_i
      @stations.each_with_index do |station, number|
        puts "станция #{station.name} - номер #{number}"
      end
      puts "Введите номер станции"
      number_station = gets.to_i
      @routs[number_route].add_intermediate_station(@stations[number_station])
    end
  end

  def del_station_in_route
    if @stations.empty?
      puts "Вы не создали станцию"
    elsif @routs.empty?
      puts "Вы не создали маршрут"
    else
      @routs.each_with_index do |route, number|
        puts "маршрут #{route.name} - номер #{number}"
      end
      puts "Введите номер маршрута"
      number_route = gets.to_i
      @stations.each_with_index do |station, number|
        puts "станция #{station.name} - номер #{number}"
      end
      puts "Введите номер станции"
      number_station = gets.to_i
      @routs[number_route].del_intermediate_station(@stations[number_station])
    end
  end

  def take_route_for_train
    if @routs.empty?
      puts "Вы не создали маршрут"
    elsif @trains.empty?
      puts "Вы не создали поезд"
    else
      @routs.each_with_index do |route, number|
        puts "маршрут #{route.name} - номер #{number}"
      end
      puts "Введите номер маршрута"
      number_route = gets.to_i
      @trains.each_with_index do |train, number|
        puts "поед #{train.number} - номер #{number}"
      end
      puts "Введите номер поезда"
      number_train = gets.to_i
      @trains[number_train].take_route(@routs[number_route])
    end
  end

  def add_wagon_for_train
    if @trains.empty?
      puts "Создайте поезд"
    else
      @trains.each_with_index do |train, number|
        puts "поезд #{train.number} - номер #{number}"
      end
      puts "Выберите поезд"
      train = gets.to_i
      selected_train = @trains[train]
      return unless selected_train.speed == 0
      wagon_class = case selected_train
        when PassengerTrain
          PassengerWagon
        when CargoTrain
          FreightWagon
        else
          return
      end
      puts "Введите номер вагона"
      number_wagon = gets.to_i
      wagon = wagon_class.new(number_wagon)
      selected_train.add_wagon(wagon)
      @wagons << wagon
    end
  end

  def del_wagon_for_train
    if @trains.empty?
      puts "Создайте поезд"
    elsif @wagons.empty?
      puts "Добавьте вагон к поезду"
    else
      @trains.each_with_index do |train, number|
        puts "поезд #{train.number} - номер #{number}"
      end
      puts "Выберите номер поезд"
      train = gets.to_i
      @wagons.each_with_index {|wagon, number| puts "Вагон номер #{wagon.number} - номер #{number}"}
      puts "Выберите номер вагона"
      wagon = gets.to_i
      @trains[train].del_wagon(@wagons[wagon]) if @trains[train].speed == 0
    end
  end

  def move_train_route_forward
    if @trains.empty?
      puts "Создайте поезд"
    else
      @trains.each_with_index { |train, number| puts "поезд #{train.number} - номер #{number}" }
      puts "Выберите номер поезда"
      train = gets.to_i
      @trains[train].go_next_station
    end
  end

  def move_train_route_back
    if @trains.empty?
      puts "Создайте поезд"  
    else
      @trains.each_with_index { |train, number| puts "поезд #{train.number} - номер #{number}" }
      puts "Выберите номер поезд"
      train = gets.to_i
      @trains[train].go_previouse_station
    end
  end

  def show_information
    @stations.each do |station| 
      puts "Станция #{station.name}:"
      station.trains.each { |train| puts "Поезд #{train.number}"}
    end
  end
end

Main.new.run

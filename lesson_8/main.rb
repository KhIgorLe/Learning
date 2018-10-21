require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'freight_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'wagon'

class Main
  TRAIN_TYPES = { 1 => PassengerTrain, 2 => CargoTrain }.freeze

  MAIN_MENU = <<-MENU.freeze
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
    Введите 12 - Просматривать станции у поезда
    Введите 13 - Просматривать список вагонов для поезда
    Введите 14 - Занять место или объем в вагоне
    Введите 0 - Выйти из программы
  MENU

  def initialize
    @stations = Station.all
    @routs = Route.all
    @trains = Train.all
    @wagons = Wagon.all
  end

  def run
    command = ''
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
      when 7 then add_wagon
      when 8 then del_wagon
      when 9 then move_train_route_forward
      when 10 then move_train_route_back
      when 11 then show_list_trains_for_station
      when 12 then show_station_for_train
      when 13 then show_list_wagons_for_train
      when 14 then take_volume_in_wagon
      when 0 then break
      else
        puts 'Команда введена не правильно'
      end
      debug
    end
  end

  def debug
    puts Station.all.to_s
    puts Train.all.to_s
    puts Route.all.to_s
    puts 'Вагоны', Wagon.all.to_s
  end

  private

  def create_station
    print 'Введите название станции: '
    name = gets.chomp

    Station.new(name)

    puts "Станция #{name} создана"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_train
    print 'Введите номер поезда: '
    number = gets.chomp

    puts 'Выберите 1 - создать пассажирский, 2 - создать грузовой поезд'

    choise = gets.to_i
    klass = TRAIN_TYPES[choise] || Train
    train = klass.new(number)

    puts "#{train.type} поезд номер #{number} создан"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def create_route
    Route.new(@stations.first, @stations.last)
    puts "Маршрут #{@stations.first.name}, #{@stations.last.name} создан"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def add_station_in_route
    return station_text if @stations.empty?
    return route_text if @routs.empty?

    get_route.add_intermediate_station(get_station)
  end

  def del_station_in_route
    return station_text if @stations.empty?
    return route_text if @routs.empty?

    get_route.del_intermediate_station(get_station)
  end

  def take_route_for_train
    return route_text if @routs.empty?
    return create_train_text if @trains.empty?

    get_train.take_route(get_route)
  end

  def add_wagon
    return create_train_text if @trains.empty?

    train = get_train

    return if train.speed != 0

    wagon_class = train.accept_class_wagon
    select_wagon_text

    if wagon_class == PassengerWagon
      number_wagon = gets.to_i
      puts 'Введите количество мест в вагоне'
      quantity_all_places = gets.to_i
      wagon = wagon_class.new(number_wagon, quantity_all_places)
      train.add_wagon(wagon)
    elsif wagon_class == FreightWagon
      number_wagon = gets.to_i
      puts 'Введите объем вагона'
      total_volume = gets.to_i
      wagon = wagon_class.new(number_wagon, total_volume)
      train.add_wagon(wagon)
    end
  end

  def del_wagon
    return create_train_text if @trains.empty?
    return add_wagon_text if @wagons.empty?

    train = get_train
    train.del_wagon(get_wagon) if train.speed.zero?
  end

  def move_train_route_forward
    return create_train_text if @trains.empty?

    get_train.go_next_station
  end

  def move_train_route_back
    return create_train_text if @trains.empty?

    get_train.go_previous_station
  end

  def take_volume_in_wagon
    return add_wagon_text if @wagons.empty?

    train = get_train
    wagon = select_wagon(train)
    wagon_class = train.accept_class_wagon

    if wagon_class == PassengerWagon
      wagon.take_place
    elsif wagon_class == FreightWagon
      puts 'Введите объем груза'
      volume = gets.to_i
      wagon.take_volume(volume)
    end
  end

  def show_list_trains_for_station
    @stations.each do |station|
      puts "На станции #{station.name} находятся поезда:"
      station.each_trains do |train|
        puts "Номер поезда #{train.number}, Тип #{train.type}, Количество вагонов - #{train.wagons.size}"
      end
    end
  end

  def show_list_wagons_for_train
    @trains.each do |train|
      puts "У поезда номер #{train.number}:"
      train.each_wagon do |wagon|
        information_wagon(wagon, train)
      end
    end
  end

  def information_wagon(wagon, train)
    a = "Вагон номер #{wagon.number}: типа вагона #{train.type},"
    wagon_class = train.accept_class_wagon

    if wagon_class == PassengerWagon
      puts "#{a} свободных мест #{wagon.empty_volume}, занятых мест #{wagon.occupied_volume}"
    elsif wagon_class == FreightWagon
      puts "#{a} свободный объём #{wagon.empty_volume}, занятый объём #{wagon.occupied_volume}"
    end
  end

  def show_station_for_train
    train = get_train
    puts "Поезд #{train.number} имеет станции:"
    train.route.stations.each { |station| puts station.name.to_s }
  end

  def get_train
    @trains.each_with_index { |train, number| puts "поезд #{train.number} - номер #{number}" }
    puts 'Выберите номер поезд'
    train = gets.to_i
    raise 'Вы не выбрали позед' if train >= @trains.size

    @trains[train]
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def get_route
    @routs.each_with_index { |route, number| puts "маршрут #{route.name} - номер #{number}" }
    puts 'Введите номер маршрута'
    number_route = gets.to_i
    raise 'Вы не выбрали маршрут' if number_route >= @routs.size

    @routs[number_route]
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def get_station
    @stations.each_with_index { |station, number| puts "станция #{station.name} - номер #{number}" }
    puts 'Введите номер станции'
    number_station = gets.to_i
    raise 'Вы не выбрали станцию' if number_station >= @stations.size

    @stations[number_station]
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def get_wagon
    @wagons.each_with_index { |wagon, number| puts "Вагон номер #{wagon.number} - номер #{number}" }
    select_wagon_text
    wagon = gets.to_i
    raise 'Вы не выбрали вагон' if wagon >= @wagons.size

    @wagons[wagon]
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def select_wagon(train)
    train.wagons.each_with_index { |wagon, number| puts "Вагон номер #{wagon.number} - номер #{number}" }
    select_wagon_text
    wagon = gets.to_i
    raise 'Вы не выбрали вагон у поезда' if wagon >= train.wagons.size

    train.wagons[wagon]
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def station_text
    puts 'Вы не создали станцию'
  end

  def create_train_text
    puts 'Создайте поезд'
  end

  def select_wagon_text
    puts 'Введите номер вагона'
  end

  def add_wagon_text
    puts 'Добавьте вагон к поезду'
  end

  def route_text
    puts 'Вы не создали маршрут'
  end
end

Main.new.run

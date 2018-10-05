=begin
Имеет начальную и конечную станцию, а также список промежуточных станций.
Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :stations, :name

  def initialize(begin_station, end_station)
    @stations = [begin_station, end_station]
    @name = "#{begin_station.name} - #{end_station.name}"
  end

  def add_intermediate_station(name_station)
    @stations.insert(-2, name_station)
  end

  def del_intermediate_station(name_station)
    @stations.delete(name_station) unless [@stations.first, @stations.last].include?(name_station)
  end

  def list_all_station
    @stations.each { |name| puts "Станция #{name}" }
  end
end

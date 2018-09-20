=begin
Имеет начальную и конечную станцию, а также список промежуточных станций.
Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :list_station

  def initialize(begin_station, end_station)
    @begin_station
    @end_station
    @list_station = [begin_station, end_station]
  end

  def add_intermediate_station(name_station)
    @list_station.insert(-2, name_station)
  end

  def del_intermediate_station(name_station)
    @list_station.delete(name_station) if
    list_station.first != name_station && list_station.last != name_station
  end

  def list_all_station
    @list_station.each { |name| puts "Станция #{name}" }
  end
end

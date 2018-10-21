require_relative 'instance_counter'
require_relative 'valid'

class Route
  include InstanceCounter
  include Valid
  attr_reader :stations, :name

  @@routs = []

  def initialize(*stations)
    @stations = stations
    validate!
    @name = "#{@stations.first.name} - #{@stations.last.name}"
    @@routs << self
    register_instance
  end

  def self.all
    @@routs
  end

  def add_intermediate_station(station)
    @stations.insert(-2, station) unless @stations.include?(station)
  end

  def del_intermediate_station(station)
    @stations.delete(station) unless [@stations.first, @stations.last].include?(station)
  end

  def list_all_station
    @stations.map { |station| puts "Станция #{station.name}" }
  end

  protected

  def validate!
    raise 'Необходимо как минимум две станции' if @stations.empty?
    raise 'Для создания маршрута необходимо создать две станции' if @stations.compact.size < 2
    raise 'Маршурт создан не из станций' unless @stations.last.is_a?(Station) && @stations.first.is_a?(Station)
  end
end

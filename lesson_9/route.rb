require_relative 'instance_counter'
require_relative 'acсessors'
require_relative 'validation'

class Route
  include InstanceCounter
  extend Acсessors
  include Validation

  attr_accessor_with_history :stations, :name

  validate :stations, presence: true
  validate :stations, length_min: 2
  validate :stations, type: Station

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
end

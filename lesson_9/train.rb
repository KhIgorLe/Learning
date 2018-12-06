require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Company
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[а-я0-9ё]{3}-?[а-я0-9ё]{2}$/i

  attr_reader :speed, :type, :route, :number, :wagons

  validate :number, format: NUMBER_FORMAT
  validate :number, :type, presence: true
  validate :number, uniqueness: true

  @@trains = []

  class << self
    def all
      @@trains
    end

    def find(number)
      @@trains.find { |train| train.number == number }
    end
  end

  def initialize(number, options = {})
    @number = number
    @type = options[:type]
    @speed = 0
    @wagons = []
    validate!
    @@trains << self
    register_instance
  end

  def go(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed -= speed if @speed > speed
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.is_a?(accept_class_wagon)
  end

  def del_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
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
    return unless next_station

    station_send_train
    @index_station += 1
    station_take_train
  end

  def go_previous_station
    return unless previous_station

    station_send_train
    @index_station -= 1
    station_take_train
  end

  def next_station
    @route.stations[@index_station + 1]
  end

  def previous_station
    @route.stations[@index_station - 1] if @index_station.positive?
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  protected

  def station_take_train
    current_station.take_train(self)
  end

  def station_send_train
    current_station.send_train(self)
  end
end

=begin
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется
из списка поездов, находящихся на станции).
=end

require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid
  attr_reader :trains, :name

  @@stations = []

  def initialize(name_station)
    @name = name_station
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def take_train(train)
    @trains << train
  end

  def count_train_type(type)
    @trains.count { |train| train.type.eql?(type) }
  end

  def send_train(train)
    @trains.delete(train)
  end

  def list_trains(&train)
    @trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise "Имя станции не может быть nil" if @name.nil?
    raise "Имя станции не может быть меньше 4 символов" if @name.length < 4
  end
end

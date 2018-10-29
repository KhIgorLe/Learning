require_relative 'instance_counter'
require_relative 'valid'

class Station
  include InstanceCounter
  include Valid
  attr_reader :trains, :name

  @@stations = []

  def initialize(name)
    @name = name
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

  def each_trains
    @trains.each { |train| yield(train) }
  end

  protected

  def validate!
    raise 'ВЫ не ввели название станции' if @name.to_s.empty?
    raise 'Имя станции не может быть меньше 4 символов' if @name.to_s.length < 4
    raise 'Станция уже существует' if station_present?
  end

  def station_present?
    @@stations.map(&:name).include?(name)
  end
end

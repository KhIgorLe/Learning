require_relative 'instance_counter'
require_relative 'acсessors'
require_relative 'validation'

class Station
  include InstanceCounter
  extend Acсessors
  include Validation

  attr_accessor_with_history :name, :trains

  validate :name, presence: true
  validate :name, length_min: 4
  validate :name, uniqueness: true
  validate :name, type: String

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
end

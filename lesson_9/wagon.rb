require_relative 'company'
require_relative 'acсessors'
require_relative 'validation'

class Wagon
  include Company
  extend Acсessors
  include Validation

  attr_reader :number, :occupied_volume

  strong_attr_accessor :full_volume, Float
  strong_attr_accessor :number, Integer

  validate :number, :full_volume, presence: true

  @@wagons = []

  def initialize(number, full_volume)
    @number = number
    @full_volume = full_volume
    @occupied_volume = 0
    @empty_volume = full_volume
    validate!
    @@wagons << self
  end

  def self.all
    @@wagons
  end

  def take_volume(volume)
    @occupied_volume += volume if volume <= empty_volume
    empty_volume
  end

  def empty_volume
    @empty_volume = @full_volume - @occupied_volume
  end
end

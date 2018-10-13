require_relative 'company'
require_relative 'valid'

class Wagon
  include Company
  include Valid
  attr_reader :number

  def initialize(number)
    @number = number
    validate!
  end

  protected

  def validate!
    raise "Номер вагона не может быть пустым" if @number.nil?
  end
end

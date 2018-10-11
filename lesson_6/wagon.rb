class Wagon
  include Company
  attr_reader :number

  def initialize(number)
    @number = number
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Номер вагона не может быть пустым" if @number.nil?
  end
end

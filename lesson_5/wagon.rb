class Wagon
  include Company
  attr_reader :number

  def initialize(number)
    @number = number
  end
end
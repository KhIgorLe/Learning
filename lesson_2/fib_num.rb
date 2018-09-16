#заполнить массив числами фибоначчи до 100

number_fib = [0, 1]
  
number_fib.each do |n| 
  fib_next = number_fib[-1] + number_fib[-2] 
  break if fib_next > 100
  number_fib << fib_next 
end

puts number_fib

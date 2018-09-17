#заполнить массив числами фибоначчи до 100

numbers_fibonacci = [0, 1]
  
while numbers_fibonacci.last + numbers_fibonacci[-2] < 100 do
  next_number = numbers_fibonacci[-1] + numbers_fibonacci[-2]
  numbers_fibonacci << next_number 
end

puts numbers_fibonacci

#count = [10]

#Заполнить массив числами от 10 до 100 с шагом 5

array = [10]

array.each { |n| array << (n += 5) if n < 100 }  
  
puts array

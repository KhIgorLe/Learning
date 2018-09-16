
=begin
Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
  (Запрещено использовать встроенные в ruby методы для этого вроде Date

Год високосный, если он делится на четыре без остатка, но если он делится на 100 без остатка, это не високосный год.
Однако, если он делится без остатка на 400, это високосный год. Таким образом, 2000 г. является особым високосным годом,
который бывает лишь раз в 400 лет.
=end

puts "Введите день месяца"
day = gets.to_i

puts "Введите номер месяца"
month = gets.to_i

puts "Введите год"
year = gets.to_i

count_days_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31 ,30, 31]

count_days_month.each_with_index { |n, i| day += n if i < month -1 }  

day += 1 if (year % 4 == 0 || year % 400 == 0 && year % 100 != 0) && (month > 2 && day > 28)
  
puts day
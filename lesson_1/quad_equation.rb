puts "Введите первый коэффициент"
a = gets.to_f

puts "Введите второй коэффициент"
b = gets.to_f

puts "Введите третий коэффициент"
c = gets.to_f

d = b**2 - 4 * a * c

if d > 0
  square_root = Math.sqrt(d)
  x1 = (-b + square_root) / (2 * a)
  x2 = (-b - square_root) / (2 * a)
  puts "Дискриминант d = #{d}"
  puts "Корень x1 = #{x1}; Корень x2 = #{x2}"
elsif d == 0
  x1 = -b / (2 * a)
  puts "Дискриминант d = #{d}"
  puts "Корень = #{x1}"
else
  puts "Дискриминант d = #{d}, Корней нет"
end

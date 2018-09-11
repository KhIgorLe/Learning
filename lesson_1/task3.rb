puts "Введите длину трёх сторон треугольника"
a = gets.to_f
b = gets.to_f
c = gets.to_f

f_side = a**2
s_side = b**2
t_side = c**2

if f_side == s_side + t_side || s_side == f_side + t_side || t_side == f_side + s_side
  puts "Треугольник является прямоугольным"
  if a == b || a == c || b == c
    puts "Треугольник также равнобедренный"
  end
end 

if a == b && b == c
  puts "Треугольник равнобедренный и равносторонний"
end

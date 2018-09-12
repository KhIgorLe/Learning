puts "Введите длину трёх сторон треугольника"
a = gets.to_f
b = gets.to_f
c = gets.to_f

if a > b && a > c 
  big_side = a
  kat1 = b
  kat2 = c
elsif b > a && b > c
  big_side = b
  kat1 = a
  kat2 = c
else
  big_side = c
  kat1 = a
  kat2 = b    
end

right_triangle = big_side**2 == kat1**2 + kat2**2 

if right_triangle && kat1 == kat2
  puts "Треугольник является прямоугольным и равнобедренным"
elsif right_triangle
  puts "Треугольник является прямоугольным"
elsif a == b && b == c 
  puts "Треугольник равнобедренный и равносторонний" 
end

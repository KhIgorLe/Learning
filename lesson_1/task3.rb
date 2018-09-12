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

big_side_sq = big_side**2
kat1_sq = kat1**2
kat2_sq = kat2**2
sum_kat = kat1_sq + kat2_sq 

if big_side_sq == sum_kat && kat1 == kat2
  puts "Треугольник является прямоугольным и равнобедренным"
elsif  big_side_sq == sum_kat
  puts "Треугольник является прямоугольным"
elsif a == b && b == c 
  puts "Треугольник равнобедренный и равносторонний" 
end

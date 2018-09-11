puts "Как тебя зовут?"
name = gets.chomp.capitalize

puts "Какой у тебя рост?"
height = gets.to_i

ideal_weight = height - 110

if ideal_weight < 0
  puts "#{name}, Ваш вес уже оптимальный"
else
  puts "#{name}, Ваш идеальный вес составляет #{ideal_weight} кг."
end

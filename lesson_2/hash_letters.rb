#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

alphabet = ("a".."z")
vowels_letters = ["a", "e", "i", "o", "u"] 

vowels_lettes_with_number = {}

alphabet.each_with_index do |leter, number| 
  vowels_lettes_with_number[leter] = number + 1 if vowels_letters.include?(leter)
end

puts vowels_lettes_with_number

#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).

letters = ("a".."z")
vowels = ["a", "e", "i", "o", "u"] 

hash_vowels = {}

letters.each_with_index { |l, i| hash_vowels[l] = i + 1 if vowels.include?(l) } 

puts hash_vowels
